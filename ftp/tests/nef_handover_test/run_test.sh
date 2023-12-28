#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2023-12-26 21:07:30

export nef_ue_path_loss_test_reporting_api_ip=10.255.28.173
export nef_ue_path_loss_test_reporting_api_port=3000
export nef_ue_path_loss_test_mini_api_endpoint_to_invoke=http://10.255.28.206:3001/start/7
export nef_ue_path_loss_test_ue1_supi=202010000000001
python3 -m robot .