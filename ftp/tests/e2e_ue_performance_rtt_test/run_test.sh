#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 16:47:51

export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke=http://127.0.0.1:8000/start/8?server_ip=127.0.0.1
export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_results=http://127.0.0.1:8000/results/8
export e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_cleanup=http://127.0.0.1:8000/stop/8
export e2e_ue_performance_rtt_test_threshold=0.9
python3 -m robot .
