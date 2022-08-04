'''
5GASP - NetApp Surrogates - Transmission Speed KPI Test
@author: Rafael Direito <rdireito@av.it.pt> & Daniel Ruiz Villa <daniel.ruiz7@um.es> 
'''

import paramiko, re
import os
import time

host1 = os.getenv('transmission_speed_host1_ip')
username1 = os.getenv('transmission_speed_host1_username')
password1 = os.getenv('transmission_speed_host1_password')
host2 = os.getenv('transmission_speed_host2_ip')


def transmission_speed():
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
    
    stdin, stdout, stderr = client.exec_command(f"ping -c 5 {host2}")
    
    pingResult = stdout.read().decode()
    regex = re.compile(r'(.*?) = (.*?)\/(.*?)\/(.*?)\/(.*?) ms')
    result = regex.search(pingResult)

    print(pingResult)

    if result:
        avgTimeTransmission = float(result.group(3))
        print('AVG:', avgTimeTransmission)

        return avgTimeTransmission

    else:
        return -1


if __name__ == '__main__':

    transmission_speed()

