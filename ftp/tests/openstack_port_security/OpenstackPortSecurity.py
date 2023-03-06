# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-06 10:01:53
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-06 15:07:49


# Return Codes:
# 0 - OK
# 1 - Tests Failed - Some Ports Are Not Secure!
# 2 - Impossible to load deployment info
# 3 - Impossible to load all deployed NFs
# 4 - Impossible to get the information of all network interfaces.

import os
import json
import re


def test_openstack_port_security(deployment_info_file_path):

    deployment_info = None

    # Load deployment info file
    try:
        f = open(deployment_info_file_path)
        deployment_info = json.load(f)
    except Exception as e:
        print(f"Impossible to load deployment info from \
            '{deployment_info_file_path}'. Exception {e}!")
        return 2, f"Impossible to load deployment info. Exception {e}"

    # Get all ConnectionPoints in deployment

    # 1. Get All deployed NFs
    deployed_nfs_ids = set()
    try:
        for artifact_data in deployment_info.values():
            if "nsd" in artifact_data.keys():
                deployed_nfs_ids = deployed_nfs_ids.union(
                    set(artifact_data["constituent-vnfr-ref"])
                )
    except Exception as e:
        print(f"Impossible to load all deployed NFs. Exception {e}!")
        return 3, f"Impossible to load all deployed NFs. Exception {e}!"

    # Some prints to provide better debugging experience for the developers
    print("Deployed Virtual Network Functions:")
    for deployed_nf_id in deployed_nfs_ids:
        print(f"\tID: {deployed_nf_id}")

    # 2. Get VIM deployment information from all NFs
    interfaces_vim_info = {}
    try:
        for nf_data in deployment_info.values():
            if "id" in nf_data.keys() and nf_data["id"] in deployed_nfs_ids:

                interfaces_vim_info[nf_data["id"]] = {}

                # Get port security info and ip for each inteface
                for vdur in nf_data["vdur"]:
                    for vim_info in vdur["vim_info"].values():
                        for interface in vim_info["interfaces"]:

                            port_security = re.search(
                                r"port_security_enabled: (false|true)",
                                interface["vim_info"]
                            ).group(1)

                            port_ip = re.search(
                                r"ip_address: ([^,]*)",
                                interface["vim_info"]
                            ).group(1)

                            interfaces_vim_info[nf_data["id"]][interface["vim_interface_id"]] = {
                                    "port_security": port_security,
                                    "port_ip": port_ip
                                }

    except Exception as e:
        print("Impossible to get the information of all network interfaces." +
              f"Exception {e}!")
        return 4, "Impossible to get the information of all network "\
            f"interfaces. Exception {e}!"

    # Some prints to provide better debugging experience for the developers
    # Also collect ports without port security enabled
    insecure_ports = []
    print("\nNetwork Information on the Deployed Virtual Network Functions:")
    for vnf_id, interface_vim_info in interfaces_vim_info.items():
        print(f"\tVNF ID: {vnf_id}")
        for interface_id, interface_info in interface_vim_info.items():
            print(f"\t\t- Interface ID: {interface_id}")
            print(f"\t\t  Port Security: {interface_info['port_security']}")
            print(f"\t\t  Port IP: {interface_info['port_ip']}")

            if interface_info['port_security'] == "false":
                insecure_ports.append({
                    "vnf_instance_id": vnf_id,
                    "interface_id": interface_id,
                    "port_ip": interface_info['port_ip'],
                    "port_security": interface_info['port_security']
                })

    # Final test result
    if len(insecure_ports) == 0:
        print("\nAll ports have port security enabled!")
        return 0, "All ports have port security enabled!"

    print("\nNOT all ports have port security enabled! " +
          f"Ports: {insecure_ports}")
    return 1, "NOT all ports have port security enabled! "\
        f"Ports: {insecure_ports}"


if __name__ == '__main__':
    # open_ports("10.0.13.21", "22/tcp,9042/tcp,9160/tcp,12341/tcp")
    test_openstack_port_security()
