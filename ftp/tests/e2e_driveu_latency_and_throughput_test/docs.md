# E2E DriveU Latency and Throughput Test

## 1. Test Goals

This test is designed to evaluate the end-to-end latency and throughput performance for a single User Equipment (UE) within ehw network infrastructure. The primary goal is to ensure that for an individual user, the network provides efficient data transfer rates (throughput) while maintaining low latency in communications. This suite aims to simulate real-world usage scenarios to assess how well the network handles data transmission and response times for a single UE, which is critical for user experience, especially in applications requiring high-speed and real-time data processing. This testing is essential for maintaining and enhancing the overall quality of service and reliability of our network.

## 2. Test Description

Verify if the Network Application does comply with the confmal download/ upload IP throughput and latency performance required for proper operation with single UE in E2E deployment.

## 3. Inputs

Environment Variables that must be specified:
- `e2e_driveu_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke`
- `e2e_driveu_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke`
- `e2e_driveu_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke`
- `e2e_driveu_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke`
- `e2e_driveu_latency_and_throughput_test_server_ip`
- `e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold`
- `e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold`
- `e2e_driveu_latency_and_throughput_test_duration_seconds`


Example:
- `e2e_driveu_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://10.255.28.206:8000/start/Def14Perf1`
- `e2e_driveu_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://10.255.28.206:8000/stop/Def14Perf1`
- `e2e_driveu_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://10.255.28.196:8000/start/Def14Perf1`
- `e2e_driveu_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://10.255.28.196:8000/results/Def14Perf1`
- `e2e_driveu_latency_and_throughput_test_server_ip=10.255.28.206 # DriveU server ip VNF`
- `e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold=100`
- `e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold=20`
- `e2e_driveu_latency_and_throughput_test_duration_seconds=10`


## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
E2E DriveU Latency And Throughput Test
==============================================================================
E2E DriveU Latency And Throughput Test.E2E DriveU Latency And Through...
==============================================================================
Run Locust Requests Per Second Test                                   .......Throughput (Mbps): 7973.745013719981
.Mean RTT (ms): 1.095
Run Locust Requests Per Second Test                                   ...Throughput Minimum Threshold (Mbps): 100
.RTT Maximum Threshold RTT (ms): 20
Run Locust Requests Per Second Test                                   | PASS |
The Target Network Application COMPLIES with the minimum threshold set for the throughput (100 Mbps) and with the maximum threshold set for the RTT value (20 ms).
------------------------------------------------------------------------------
E2E DriveU Latency And Throughput Test.E2E DriveU Latency An... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
E2E DriveU Latency And Throughput Test                             | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
E2E DriveU Latency And Throughput Test
==============================================================================
E2E DriveU Latency And Throughput Test.E2E DriveU Latency And Through...
==============================================================================
Run Locust Requests Per Second Test                                   .......Throughput (Mbps): 8773.320520820333
.Mean RTT (ms): 0.8140000000000001
Run Locust Requests Per Second Test                                   ...Throughput Minimum Threshold (Mbps): 10000
.RTT Maximum Threshold RTT (ms): 20
Run Locust Requests Per Second Test                                   | FAIL |
The Target Network Application DOES NOT comply with the minimum threshold set for the throughput or with the maximum threshold for RTT.
------------------------------------------------------------------------------
E2E DriveU Latency And Throughput Test.E2E DriveU Latency An... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
E2E DriveU Latency And Throughput Test                             | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/e2e_driveu_latency_and_throughput_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, `DriveU` must be installed on the VNF.

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.31.0
```