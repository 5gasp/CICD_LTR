#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 16:47:51

export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke="http://localhost:31001/start/8?server_ip=k8s_service_miniapi:30102&is_cnf=true"
export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_results=http://localhost:31001/results/8
export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_cleanup=http://localhost:31001/stop/8
export e2e_ue_performance_rtt_test_threshold=10
python3 -m robot .
