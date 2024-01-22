#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 14:55:18

export nef_ue_path_loss_test_reporting_api_ip=10.255.28.236
export nef_ue_path_loss_test_reporting_api_port=3000
export nef_ue_path_loss_test_mini_api_endpoint_to_invoke=http://10.255.28.230:3001/start/Def115G5
export nef_ue_path_loss_test_ue_supi=202010000000001
python3 -m robot .
