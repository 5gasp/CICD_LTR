#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 16:47:16

export nef_ue_path_loss_test_reporting_api_ip=10.255.28.182
export nef_ue_path_loss_test_reporting_api_port=3000
export nef_ue_path_loss_test_mini_api_endpoint_to_invoke=http://127.0.0.1:8080/start/5
export nef_ue_path_loss_test_ue1_supi=202010000000001
python3 -m robot .
