# NEF Signaling Performance Requests Per Second Test

## 1. Test Goals

This test is designed to evaluate the Network Exposure Function's (NEF's) capacity to handle a significant volume of signaling requests per second. The primary objective is to ensure that the NEF can manage high traffic loads effectively, maintaining stable and efficient network performance even under peak demand. This suite tests the NEF's ability to process a large number of requests simultaneously without compromising response times or quality of service. This is crucial for verifying the NEF's scalability and reliability, particularly in scenarios where network usage is intensive. The test outcomes are vital for assuring that the NEF can support robust network operations and deliver consistent service quality.

## 2. Test Description

Validate by measuring how many requests the NEF API can serve per second.

## 3. Inputs

Environment Variables that must be specified:
- 

Example:
- 

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Requests Per Second Test
==============================================================================
Nef Signaling Performance Requests Per Second Test.Nef Signaling Performanc...
==============================================================================
Run Locust Requests Per Second Test                                   ...

Test Host: https://webhook.site
.
Test endpoint: /30f999bf-09c9-4b28-9857-dbfd4489d42f
.
Minimum Threshhold - Requests Per Second: 5 requests/sec.
Run Locust Requests Per Second Test                                   .

[RESULT] Median Requests Per Second: 10.5 requests/sec.

Run Locust Requests Per Second Test                                   | PASS |
The Target Server/API COMPLIES with the minimum threshold set for number of requests/sec (5).
------------------------------------------------------------------------------
Nef Signaling Performance Requests Per Second Test.Nef Signaling P... | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Signaling Performance Requests Per Second Test                    | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Signaling Performance Requests Per Second Test
==============================================================================
Nef Signaling Performance Requests Per Second Test.Nef Signaling Performanc...
==============================================================================
Run Locust Requests Per Second Test                                   ...

Test Host: https://webhook.site
.
Test endpoint: /ca90fd12-329d-4537-8597-47595a51808b
.
Minimum Threshhold - Requests Per Second: 20 requests/sec.
Run Locust Requests Per Second Test                                   .

[RESULT] Median Requests Per Second: 9.5 requests/sec.

Run Locust Requests Per Second Test                                   | FAIL |
The Target Server/API DOES NOT comply with the minimum threshold set for number of requests/sec (20).
------------------------------------------------------------------------------
Nef Signaling Performance Requests Per Second Test.Nef Signaling P... | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Signaling Performance Requests Per Second Test                    | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_signaling_performance_requests_per_second_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
locust==2.20.0
```