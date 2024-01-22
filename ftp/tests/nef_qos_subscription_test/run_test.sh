#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2023-12-31 17:02:22
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 15:05:32

export nef_qos_subscription_test_reporting_api_ip=10.255.28.236
export nef_qos_subscription_test_reporting_api_port=3000
export nef_qos_subscription_test_mini_api_endpoint_to_invoke=http://10.255.28.230:3001/start/Def115G7
python3 -m robot .
