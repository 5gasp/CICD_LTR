'''
5GASP - NetApp Surrogates - Packet Loss KPI Test
@author: Rafael Direito <rdireito@av.it.pt>
'''

import paramiko, re
import os
import time

host1 = os.getenv('packet_loss_host1_ip')
username1 = os.getenv('packet_loss_host1_username')
password1 = os.getenv('packet_loss_host1_password')
host2 = os.getenv('packet_loss_host2_ip')


def packet_loss():
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    MAX_RETRIES = 120
    retry = 0
    while retry < MAX_RETRIES:
        try:
            client.connect(hostname=host1, username=username1, password=password1)
        except:
            print("[!] Cannot connect to the SSH Server")
        retry += 1
        time.sleep(1)
        
    if retry == MAX_RETRIES:
        print("Could not establish SSH connection to the servers")
        return "Could not establish SSH connection to the servers"
    
    stdin, stdout, stderr = client.exec_command(f"ping -c 20 {host2}")
    
    pingResult = stdout.read().decode()
    regex = re.compile(r',( [0-9,.]+)% packet loss,')
    result = regex.search(pingResult)

    if result:
        loss_percentage = float(result.group(1))
        return loss_percentage
    else:
        return -1


if __name__ == '__main__':

    packet_loss()

