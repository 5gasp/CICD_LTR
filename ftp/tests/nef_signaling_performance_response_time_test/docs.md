# NEF Signaling Performance Response Time Test

## 1. Test Goals

This test is dedicated to evaluating the response time of the Network Exposure Function (NEF) in handling signaling requests. The overarching goal is to measure and ensure the efficiency of the NEF in processing signaling messages, which is crucial for maintaining optimal network performance and user experience. By testing how quickly the NEF can respond to various signaling scenarios, this suite aims to confirm that the NEF can reliably and swiftly handle communication demands, which is critical in a network environment where prompt response to signaling is essential for service continuity and quality. This suite is integral in verifying the NEF's capabilities to support robust and efficient network operations.

## 2. Test Description

Validate by measuring NEF API response time.

## 3. Inputs

Environment Variables that must be specified:
- `nef_signaling_performance_response_time_test_host`
- `nef_signaling_performance_response_time_test_endpoint`
- `nef_signaling_performance_response_time_test_max_response_time_threshold_secs`

Example:
- `export nef_signaling_performance_response_time_test_host=https://webhook.site`
- `export nef_signaling_performance_response_time_test_endpoint=/f04377b7-1d4c-4899-807c-c878fdffebb1`
- `export nef_signaling_performance_response_time_test_max_response_time_threshold_secs=2`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Response Time Test
==============================================================================
Nef Signaling Performance Response Time Test.Nef Signaling Performance Resp...
==============================================================================
Run Locust Requests Per Second Test                                   ...

Test Host: https://webhook.site
.
Test endpoint: /f04377b7-1d4c-4899-807c-c878fdffebb1
.
Maximum Threshhold - Response Time: 2 secs.
Run Locust Requests Per Second Test                                   ..

[RESULT] Average Response Time: 0.5183925193800003 sec.

Run Locust Requests Per Second Test                                   | PASS |
The Target Server/API COMPLIES with the maximum threshold set for the response time (2 secs).
------------------------------------------------------------------------------
Nef Signaling Performance Response Time Test.Nef Signaling Perform... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Signaling Performance Response Time Test                          | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Response Time Test
==============================================================================
Nef Signaling Performance Response Time Test.Nef Signaling Performance Resp...
==============================================================================
Run Locust Requests Per Second Test                                   ...

Test Host: https://webhook.site
.
Test endpoint: /30f999bf-09c9-4b28-9857-dbfd4489d42f
.
Maximum Threshhold - Response Time: 2 secs.
Run Locust Requests Per Second Test                                   | FAIL |
ZeroDivisionError: float division by zero
------------------------------------------------------------------------------
Nef Signaling Performance Response Time Test.Nef Signaling Perform... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Signaling Performance Response Time Test                          | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_response_time_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
locust==2.20.0
```