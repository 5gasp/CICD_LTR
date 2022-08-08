# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2022-08-04 11:24:30
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2022-08-08 12:21:30


import os
import nmap3

# Return Codes:
# 0 - OK
# 1 - Bad inputs
# 2 - Could not scan the host open ports
# 3 - The open ports are not the ones expected


def test_open_ports(host, expected_open_ports):
    try:
        # Parse the expected_open_ports string
        # expected_open_ports = "80/tcp,443/tcp,...."
        expected_open_ports_set = {
            tuple(tup.split("/"))
            for tup
            in expected_open_ports.split(',')
        }
        print(f"Expected open ports: {expected_open_ports_set}")
        # Open ports scan
        nmap = nmap3.NmapScanTechniques()
        results = nmap.nmap_tcp_scan(host, args="-Pn -p-")
        open_ports = set()
        for port in results[host]["ports"]:
            if port["state"] == "open":
                print("[Open Port]")
                print(f"Port: {port['portid']}")
                print(f"Protocol: {port['protocol']}")
                open_ports.add((port['portid'], port['protocol']))
        print(f"Open ports: {open_ports}")
        # check if the ports are the same
        if expected_open_ports_set == open_ports:
            print("Success! The open ports are the ones expected.")
            return 0
        else:
            return 3
    except Exception as e:
        print("Error", e)
        return 2

#if __name__ == '__main__':
#    #open_ports("10.0.13.21", "22/tcp,9042/tcp,9160/tcp,12341/tcp")
#    open_ports("10.0.13.21", "22/tcp")
