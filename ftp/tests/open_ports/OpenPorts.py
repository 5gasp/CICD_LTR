'''
5GASP - NetApp Surrogates - Open Ports
@author: Rafael Direito <rdireito@av.it.pt>
'''

import os
import nmap3

target = os.getenv('open_ports_host')
open_port = os.getenv('open_ports_expected_open_port')
protocol = os.getenv('open_ports_expected_protocol')
# Return Codes:
# 0 - OK
# 1 - Bad inputs
# 2 - Could not scan the host open ports
# 3 - The open ports are not the ones expected


def open_ports():
    if not open_port or not protocol or not target:
        return 1
    try:
        nmap = nmap3.NmapScanTechniques()
        results = nmap.scan_top_ports(target, args="-Pn")
        open_ports = set()
        for port in results[target]["ports"]:
            if port["state"] == "open":
                print("[Open Port]")
                print(f"Port: {port['portid']}")
                print(f"Protocol: {port['protocol']}")
                print(f"Service: {port['service']['name']}")
                open_ports.add((port['portid'], port['protocol']))
        print(open_ports)
        # check if the ports are the same
        if open_ports == {(str(open_port), protocol)}:
            return 0
        else:
            return 3
    except:
        return 2

if __name__ == '__main__':
    open_ports()
