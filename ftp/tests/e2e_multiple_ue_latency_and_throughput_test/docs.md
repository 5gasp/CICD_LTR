# E2E Multiple UE Latency and Throughput Test

## 1. Test Goals

This test is focused on assessing the network's performance in terms of latency and throughput when handling multiple User Equipments (UEs) simultaneously. The main objective is to ensure that the network can efficiently manage data transmission rates and maintain optimal latency levels across a range of UEs under varying load conditions. This testing is critical for evaluating the network's capacity to provide consistent and reliable service in scenarios with high user density or high demand, ensuring that all users experience satisfactory levels of responsiveness and data transfer speed. This suite is integral for validating the network's capability to deliver high-quality service in diverse and demanding usage environments.

## 2. Test Description

Verify if the Network Application does comply with the minimal download/ upload IP throughput and Latency performance required for proper operation with multiple UE in E2E deployment.

## 3. Inputs

Environment Variables that must be specified:
- `e2e_multiple_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke`
- `e2e_multiple_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke`
- `e2e_multiple_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke`
- `e2e_multiple_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke`
- `e2e_multiple_ue_latency_and_throughput_test_iperf_server_ip`
- `e2e_multiple_ue_latency_and_throughput_test_ue_count`
- `e2e_multiple_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold`
- `e2e_multiple_ue_latency_and_throughput_test_max_rtt_ms_threshold`

Example:
- `export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://10.255.28.206:8000/start/Def14Perf2`
- `export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://10.255.28.206:8000/stop/Def14Perf2`
- `export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://10.255.28.196:8000/start/Def14Perf2`
- `export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://10.255.28.196:8000/results/Def14Perf2`
- `export e2e_multiple_ue_latency_and_throughput_test_iperf_server_ip=10.255.28.206 # iperf server ip should point to the MiniAPI Server VNF`
- `export e2e_multiple_ue_latency_and_throughput_test_ue_count=50`
- `export e2e_multiple_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100`
- `export e2e_multiple_ue_latency_and_throughput_test_max_rtt_ms_threshold=10`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
E2E Multiple Ue Latency And Throughput Test
==============================================================================
E2E Multiple Ue Latency And Throughput Test.E2E Multiple Ue Latency And Thr...
==============================================================================
Run Locust Requests Per Second Test                                   .......Throughput (Mbps): 5734.651553233256
.Mean RTT (ms): 3.549240000000001
Run Locust Requests Per Second Test                                   ...Throughput Minimum Threshold (Mbps): 100
.RTT Maximum Threshold RTT (ms): 10
Run Locust Requests Per Second Test                                   | PASS |
The Target Network Application COMPLIES with the minimum threshold set for the throughput (100 Mbps) and with the maximum threshold set for the RTT value (10 ms).
------------------------------------------------------------------------------
E2E Multiple Ue Latency And Throughput Test.E2E Multiple Ue Latenc... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
E2E Multiple Ue Latency And Throughput Test                           | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
E2E Multiple Ue Latency And Throughput Test
==============================================================================
E2E Multiple Ue Latency And Throughput Test.E2E Multiple Ue Latency And Thr...
==============================================================================
Run Locust Requests Per Second Test                                   .......Throughput (Mbps): 5974.303537034337
.Mean RTT (ms): 3.3080000000000003
Run Locust Requests Per Second Test                                   ...Throughput Minimum Threshold (Mbps): 10000
.RTT Maximum Threshold RTT (ms): 10
Run Locust Requests Per Second Test                                   | FAIL |
The Target Network Application DOES NOT comply with the minimum threshold set for the throughput or with the maximum threshold for RTT.
------------------------------------------------------------------------------
E2E Multiple Ue Latency And Throughput Test.E2E Multiple Ue Latenc... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
E2E Multiple Ue Latency And Throughput Test                           | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_multiple_ue_latency_and_throughput_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, `iperf3` must be installed on the VNF.

### 5.2. Python Requirements