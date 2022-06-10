'''
5GASP - NetApp Surrogates - Bandwidth KPI Test
@author: Rafael Direito <rdireito@av.it.pt> & Daniel Ruiz Villa <daniel.ruiz7@um.es> 
'''

import paramiko, re
import statistics as stats
import json
import os
import time
from aux.nods_information_parser import NetworkInformationParser 

network_info = os.getenv('bandwidth2_network_info')

host1 = os.getenv('bandwidth2_host1_ip')
username1 = os.getenv('bandwidth2_host1_username')
password1 = os.getenv('bandwidth2_host1_password')

host2 = os.getenv('bandwidth2_host2_ip')
username2 = os.getenv('bandwidth2_host2_username')
password2 = os.getenv('bandwidth2_host2_password')

net_information_parser = NetworkInformationParser(network_info)
host1_ip = net_information_parser.get_field_info(host1)
host2_ip = net_information_parser.get_field_info(host2)

def install_dependencies(client):
    stdin, stdout, stderr = client.exec_command(
        "sudo apt update -y &>/dev/null ; echo $?"
    )
    status_code = stdout.read().decode().strip()
    # control
    if status_code != "0": return False
    
    stdin, stdout, stderr = client.exec_command(
        "sudo apt install iperf3 -y &>/dev/null ; echo $?"
    )
    status_code = stdout.read().decode().strip()
    # control
    if status_code != "0": return False
    
    print("Installed all dependencies") 
    return True

#test
def bandwidth2():
    machine1 = paramiko.SSHClient()
    machine1.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    machine2 = paramiko.SSHClient()
    machine2.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        machine1.connect(
            hostname=host1_ip, 
            username=username1, 
            password=password1
        )
        machine2.connect(
            hostname=host2_ip,
            username=username2,
            password=password2
        )
    except Exception as e:
        print(f"[!] Cannot connect to the SSH Server - {e}")
        return False

    # Install dependencies
    if not install_dependencies(machine1): return False
    if not install_dependencies(machine2): return False
    
    print("host1_ip", host1_ip)
    print("host2_ip", host2_ip)
    # Executing iPerf commands
    machine1.get_transport().open_session().exec_command("sudo iperf3 -s -&>/dev/null &")
    print("Running iPerf3 server on host1")
    time.sleep(5)
    
    stdin, stdout, stderr = machine2.exec_command(f"iperf3 -c {host1_ip} --json -t 5")
    iperfResult = stdout.read().decode()
    print("iperfResult", iperfResult)
    bits_per_second_results = []
    obj = json.loads(iperfResult)
    machine1.exec_command('pkill iperf3')
    for iteration_data in (obj['intervals']):
        bits_per_second_results.append(iteration_data["sum"]["bits_per_second"])
    
    if len(bits_per_second_results) > 0: 
        # Calculating the packet loss mean between Sender and Receiver
        mean_bw_mbits_per_second = stats.mean(bits_per_second_results)/1000000
        print("mean_bw_mbits_per_second", mean_bw_mbits_per_second)
        return mean_bw_mbits_per_second
    else:
        return "Not found"


if __name__ == '__main__':
    bandwidth2()
