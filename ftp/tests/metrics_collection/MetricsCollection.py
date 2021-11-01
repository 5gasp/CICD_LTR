'''
5GASP - NetApp Metrics Collection
@author: Rafael Direito <rdireito@av.it.pt>
'''

import inspect
import paramiko
from scp import SCPClient
import os

currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))

host = os.getenv('metrics_collection_host')
username = os.getenv('metrics_collection_host_username')
password = os.getenv('metrics_collection_host_password')
action = os.getenv('metrics_collection_action')
influx_db_url = os.getenv("INFLUX_DB_URL")
influx_db_name = os.getenv("INFLUX_DB_NAME")


class MetricsCollectionException(Exception):
    error_codes = {
        1: "Cannot connect to the SSH Server",
        2: "Cannot transfer files via  SCP",
        3: "Cannot move the files to their correct location",
        4: "Cannot start telegraf's service",
        5: "Telegraf's service was started with errors",
        6: "Cannot stop telegraf's service",
    }
    def __init__(self, code, exception):
        self.code = code
        self.error_message = self.error_codes[code]
        self.exception = exception

    def __str__(self):
        return (self.code)


def execute_ssh_command(client, command):
    stdin, stdout, stderr = client.exec_command(command)
    if stdin.channel.recv_exit_status() != 0:
        print("stdin code:", stdin.channel.recv_exit_status())
    if stdout.channel.recv_exit_status() != 0:
        print("stdout code:", stdout.channel.recv_exit_status())
    if stderr.channel.recv_exit_status() != 0:
        print("stderr code:", stderr.channel.recv_exit_status())
    return stdout


def make_ssh_connection():
    # create the connection
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        client.connect(hostname=host, username=username, password=password)
    except Exception as e:
        raise MetricsCollectionException(1, e)
    return client


def transfer_needed_files(client):
    integrity_checksums = [
        "dff5bee6408b3b1825548c4758913cbaa6c8bd7d4d4b2dd9e4c01a46ae7219bb",
        "3cbb1b4198f746f50d4c6b97f903e601726c656c0185783e3a214f6aad09925e",
        "6d292ea62bbd960e6d8eb8dde08e159c01b796544252daefd6dae10e88b26bbe",
    ]
    for i in range (3):
        # transfer files
        try:
            scp_client = SCPClient(client.get_transport())
            ret = scp_client.put(os.path.join(currentdir,'telegraf'), remote_path='~/telegraf')
            ret = scp_client.put(os.path.join(currentdir,'telegraf.conf'), remote_path='~/telegraf.conf')
            ret = scp_client.put(os.path.join(currentdir,'telegraf.service'), remote_path='~/telegraf.service')
        except Exception as e:
            client.close()
            raise MetricsCollectionException(2, e)

        # check integrity
        try:
            checksums = []
            stdout = execute_ssh_command(client, f"echo {password} | sha256sum ~/telegraf")
            checksums.append(stdout.read().decode().split()[0].strip())
            stdout = execute_ssh_command(client, f"echo {password} | sha256sum ~/telegraf.conf")
            checksums.append(stdout.read().decode().split()[0].strip())
            stdout = execute_ssh_command(client, f"echo {password} | sha256sum ~/telegraf.service")
            checksums.append(stdout.read().decode().split()[0].strip())
            print("checksums:", checksums)
            print("integrity_checksums:", integrity_checksums)
            if checksums == integrity_checksums:
                break
        except Exception as e:
            client.close()
            raise MetricsCollectionException(2, e)

        if i == 2:
            raise MetricsCollectionException(2, "")
    # move the files to their correct location
    try:
        execute_ssh_command(client, f"echo {password} | sudo -S chmod +x ~/telegraf")
        execute_ssh_command(client, f"echo {password} | sudo -S mv ~/telegraf /usr/bin")
        execute_ssh_command(client, f"echo {password} | sudo -S mv ~/telegraf.service /etc/systemd/system")
        execute_ssh_command(client, f"echo {password} | sudo -S systemctl daemon-reload")
    except Exception as e:
        client.close()
        raise MetricsCollectionException(3, e)
    
    
def run_metrics_collection(client):
    try:
        execute_ssh_command(client, f"echo {password} | sudo -S systemctl set-environment INFLUX_DB_URL={influx_db_url}")
        execute_ssh_command(client, f"echo {password} | sudo -S systemctl set-environment INFLUX_DB_NAME={influx_db_name}")
        execute_ssh_command(client, f"echo {password} | sudo -S service telegraf start")
        stdout = execute_ssh_command(client, f"echo {password} | sudo -S service telegraf status")
        output = str(stdout.read().decode())
        print("run_metrics_collection:", output)
        print("---")
        if ("active (running)" in output):
            print("Service is Running")
            client.close()
        else:
            client.close()
            raise MetricsCollectionException(5, None)
    except Exception as e:
        client.close()
        raise MetricsCollectionException(4, e)
        

def stop_metrics_collection(client):
    try:
        execute_ssh_command(client, f"echo {password} | sudo service telegraf stop")
        stdout = execute_ssh_command(client, f"echo {password} | sudo service telegraf status")
        output = str(stdout.read().decode())
        print("stop_metrics_collection:", output)
        print("---")
        if "inactive" in output or "failed" in output:
            client.close()
        else:
            client.close()
            raise MetricsCollectionException(6, None)
    except Exception as e:
        client.close()
        raise MetricsCollectionException(6, e)
    

def main():
    try:
        client = make_ssh_connection()
        if action == "start":
            transfer_needed_files(client)
            run_metrics_collection(client)
            return 0
        elif action == "stop":
            stop_metrics_collection(client)
            return 0
    except MetricsCollectionException as e:
        print(f"[Error] Status Code: {e.code}, Error Message: {e.error_message}, Exception Text: {str(e.exception)}.")
        return e.code

if __name__ == '__main__':
    main()
