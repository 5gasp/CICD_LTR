#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-02 19:40:08


export e2e_single_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://10.255.28.159:8000/start/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://10.255.28.159:8000/stop/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://10.255.28.230:8000/start/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://10.255.28.230:8000/results/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_iperf_server_ip=10.255.28.159 # iperf server ip should point to the VM running the UE's MiniAPI
export e2e_single_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_single_ue_latency_and_throughput_test_max_rtt_ms_threshold=20


python3 -m robot .
