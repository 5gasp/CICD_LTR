#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-30 12:32:46

export hops_until_target_test_target=8.8.8.8
export hops_until_target_test_max_hops_threshold=20
export hops_until_target_test_mini_api_endpoint_to_invoke=http://10.255.28.230:8000/start/Def14Perf13
export hops_until_target_test_mini_api_endpoint_to_invoke_results=http://10.255.28.230:8000/results/Def14Perf13

python3 -m robot .
