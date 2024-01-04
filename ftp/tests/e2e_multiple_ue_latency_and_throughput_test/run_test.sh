#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-02 20:21:33


export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://10.255.28.159:8000/start/Def14Perf2
export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://10.255.28.159:8000/stop/Def14Perf2
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://10.255.28.230:8000/start/Def14Perf2
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://10.255.28.230:8000/results/Def14Perf2
export e2e_multiple_ue_latency_and_throughput_test_iperf_server_ip=10.255.28.159 # iperf server ip should point to the MiniAPI Server VNF
export e2e_multiple_ue_latency_and_throughput_test_ue_count=50
export e2e_multiple_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_multiple_ue_latency_and_throughput_test_max_rtt_ms_threshold=10


python3 -m robot .
