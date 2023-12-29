#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-29 13:37:07

export nef_ue_handover_test_reporting_api_ip=10.255.28.236
export nef_ue_handover_test_reporting_api_port=3000
export nef_ue_handover_test_mini_api_endpoint_to_invoke=http://10.255.28.230:8000/start/9
export nef_ue_handover_test_ue1_supi=202010000000001
python3 -m robot .
