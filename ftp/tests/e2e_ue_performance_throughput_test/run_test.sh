#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 16:47:51

export e2e_ue_performance_test_mini_api_endpoint_to_invoke_server=http://127.0.0.1:8080/start/7?is_server=true
export e2e_ue_performance_test_mini_api_endpoint_to_invoke_client=http://127.0.0.1:8000/start/7?server_ip=127.0.0.1
export e2e_ue_performance_test_mini_api_endpoint_to_invoke_results=http://127.0.0.1:8080/results/7
export e2e_ue_performance_test_mini_api_endpoint_to_invoke_cleanup=http://127.0.0.1:8080/stop/7
export e2e_ue_performance_test_threshold=100000
python3 -m robot .
