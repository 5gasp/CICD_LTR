#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:51:15

export maximum_number_of_connections_test_load_test_host=http://10.255.28.230:8080
export maximum_number_of_connections_test_load_test_endpoint=/
export maximum_number_of_connections_test_load_test_http_method=GET
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke=http://10.255.28.230:3001/start/Def14Perf11
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_cleanup=http://10.255.28.230:3001/stop/Def14Perf11
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_results=http://10.255.28.230:3001/results/Def14Perf11
export maximum_number_of_connections_test_connections_minimum_threshold=10
python3 -m robot .
