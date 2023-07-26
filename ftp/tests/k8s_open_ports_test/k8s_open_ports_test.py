# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-06 10:01:53
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-03-12 18:20:26


# Return Codes:
# 0 - OK
# 1 - Tests Failed - Some Ports Are Not Secure!
# 2 - Impossible to load deployment info
# 3 - Impossible to load all deployed NFs
# 4 - Impossible to get the information of all network interfaces.

import os
import json
import re
import yaml
import ast

def test_k8s_open_ports(deployment_info_file_path, ports_list):
    ports_list = ports_list.split(",")

    if deployment_info_file_path == "NONE":
        deployment_info_file_path = os.path.join(
            "/var", "lib", "jenkins", "test_artifacts", os.getenv("JOB_NAME"),
            "deployment-info.json"
        )

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

    # 1. Get All Ports Informations
    print(ports_list)
    k8s_info = deployment_info['_admin']['deployed']['K8s']
    k8s_ports_info = []
    for kdu_instance in k8s_info:
        kdu_data = kdu_instance["detailed-status"]
        manifest = ast.literal_eval(kdu_data)['manifest']
        for item in manifest:
            if "ports" in item.get("spec", {}):
                k8s_ports_info.extend(item["spec"]["ports"])
    for input_port in ports_list:
        # We should not only validate NodePorts since there can
        # be other types of services. Thus, we should validate the port
        # field.
        if not any(int(input_port) == collected_port.get('port') \
             for collected_port in k8s_ports_info):
            return "1", "The open ports are not the ones expected"
    
    return "0", "OK. The open ports are the ones expected"


# test_k8s_open_ports(
#     deployment_info_file_path="./deployment-info.json", ports_list=[30102])