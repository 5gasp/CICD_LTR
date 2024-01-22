#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:45:32

export nef_signaling_performance_maximum_connections_test_load_test_host=http://10.255.28.230:8080
export nef_signaling_performance_maximum_connections_test_load_test_endpoint=/
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke=http://10.255.28.230:3001/start/Def14Perf7
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup=http://10.255.28.230:3001/stop/Def14Perf7
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results=http://10.255.28.230:3001/results/Def14Perf7
export nef_signaling_performance_maximum_connections_test_connections_minimum_threshold=2
python3 -m robot .
