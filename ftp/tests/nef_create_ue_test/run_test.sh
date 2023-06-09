#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 16:47:27

export nef_create_ue_test_reporting_api_ip=127.0.0.1
export nef_create_ue_test_reporting_api_port=3000
export nef_create_ue_test_mini_api_endpoint_to_invoke=http://127.0.0.1:8000/start/2
python3 -m robot .
