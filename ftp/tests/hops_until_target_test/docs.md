# Hops Until Target Test

## 1. Test Goals

This test is designed to assess the efficiency and accuracy of network routing mechanisms in determining the number of hops required to reach a target within the network. This testing is crucial for ensuring that data packets are transmitted through the most optimal paths, minimizing latency and maximizing the efficiency of network traffic management. The primary aim is to validate that the network infrastructure can effectively compute and manage routing paths, thereby ensuring reliable and efficient data transmission across the network. This suite is vital for maintaining high standards of network performance and for supporting the delivery of quality service to users.

## 2. Test Description

Validate that number of hops to the target does not exceed defined value by using ICMP request/response.

## 3. Inputs

Environment Variables that must be specified:
- `hops_until_target_test_target`
- `hops_until_target_test_max_hops_threshold`
- `hops_until_target_test_mini_api_endpoint_to_invoke`
- `hops_until_target_test_mini_api_endpoint_to_invoke_results`

Example:
- 

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Hops Until Target Test
==============================================================================
Hops Until Target Test.Hops Until Target Test
==============================================================================
Run Locust Requests Per Second Test                                   ..

Test Target: 8.8.8.8
.
Maximum Threshhold - Hops Until Target: 20 hops.
.....

Hops Until Target: 16.
Run Locust Requests Per Second Test                                   | PASS |
The Network Application was ABLE to reach the target with less than 20 hops.
------------------------------------------------------------------------------
Hops Until Target Test.Hops Until Target Test                         | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Hops Until Target Test                                                | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Hops Until Target Test
==============================================================================
Hops Until Target Test.Hops Until Target Test
==============================================================================
Run Locust Requests Per Second Test                                   ..

Test Target: 8.8.8.8
.
Maximum Threshhold - Hops Until Target: 5 hops.
.....

Hops Until Target: 16.
Run Locust Requests Per Second Test                                   | FAIL |
The Network Application was UNABLE to reach the target with less than 5 hops.
------------------------------------------------------------------------------
Hops Until Target Test.Hops Until Target Test                         | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Hops Until Target Test                                                | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/hops_until_target_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

For this test to run, `ping` must be installed on the VNF.

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.31.0
```
