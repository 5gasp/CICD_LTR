#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2023-12-31 17:02:22
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2023-12-31 18:37:32

export nef_qos_subscription_test_reporting_api_ip=10.255.28.173
export nef_qos_subscription_test_reporting_api_port=3000
export nef_qos_subscription_test_mini_api_endpoint_to_invoke=http://10.255.28.206:3001/start/def1145G7
python3 -m robot .
