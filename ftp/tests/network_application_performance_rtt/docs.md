# Network Application Performance RTT

## 1. Test Goals

This test focuses on evaluating the round-trip time (RTT) performance of network applications. The main objective is to measure the time taken for a signal to travel from a source to a destination and back again, which is a critical metric for assessing the responsiveness and efficiency of network communications. By analyzing RTT, this suite aims to ensure that network applications are performing optimally, with minimal latency, which is essential for providing a high-quality user experience, especially in time-sensitive applications. This testing is crucial for identifying potential delays and optimizing network configurations to enhance overall communication speed and reliability.

## 2. Test Description

Validate that Network Application replies to the Internet Control Message Protocol (ICMP) requests and not exceeding the configured value.

## 3. Inputs

Environment Variables that must be specified:
- `network_application_performance_rtt_target`
- `network_application_performance_rtt_threshold_ms`

Example:
- `export network_application_performance_rtt_target=5gasp.eu`
- `export network_application_performance_rtt_threshold_ms=500 # 500 milliseconds `

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Network Application Performance Rtt
==============================================================================
Network Application Performance Rtt.Network Application Performance Rtt
==============================================================================
Perf12 - Network Application Performance - IP Round-Trip (RTT) test   ..IP RTT 0.92 ms, threshold 500, target: 5gasp.eu
Perf12 - Network Application Performance - IP Round-Trip (RTT) test   | PASS |
------------------------------------------------------------------------------
Network Application Performance Rtt.Network Application Performanc... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Network Application Performance Rtt                                   | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Network Application Performance Rtt
==============================================================================
Network Application Performance Rtt.Network Application Performance Rtt
==============================================================================
Perf12 - Network Application Performance - IP Round-Trip (RTT) test   | FAIL |
'1.04 < 0.5' should be true.
------------------------------------------------------------------------------
Network Application Performance Rtt.Network Application Performanc... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Network Application Performance Rtt                                   | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/network_application_performance_rtt/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
```