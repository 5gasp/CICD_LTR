#!/bin/bash
# @Author: adi@driveu
# @Date:   2024-03-24 16:38:53
# @Last Modified by:   adi@driveu
# @Last Modified time: 2024-03-24 16:38:53

mini_api_ip_server=192.168.68.105
mini_api_server_url=http://${mini_api_ip_server}:3001


export e2e_driveu_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke="$mini_api_server_url/start/Def20Perf1"
export e2e_driveu_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke="$mini_api_server_url/stop/Def20Perf1"
export e2e_driveu_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke="$mini_api_ue_url/start/Def20Perf1"
export e2e_driveu_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke="$mini_api_ue_url/results/Def20Perf1"
export e2e_driveu_latency_and_throughput_test_server_ip=$mini_api_ip_server # IP of DriveU server VNF
export e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold=20
export e2e_driveu_latency_and_throughput_test_duration_seconds=10

python3 -m robot .
