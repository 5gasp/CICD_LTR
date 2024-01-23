# NEF Monitoring Subscription Test

## 1. Test Goals

This test will validate that a Network Application is able to retrieve an indicative UE location.

## 2. Test Description

This test is designed to comprehensively evaluate the monitoring and subscription functionalities of the Network Exposure Function (NEF) in our system. The primary objective is to ensure that NEF effectively handles and manages subscriptions and monitoring requests, maintaining high standards of performance and reliability. By thoroughly testing these functionalities, the suite aims to validate that NEF operates correctly and efficiently, ensuring consistent and secure management of network exposure data. This is crucial for the seamless integration and operation of NEF within our network's ecosystem, providing vital support for network operations and services.

## 3. Inputs

Environment Variables that must be specified:
- `nef_monitoring_subscription_test_reporting_api_ip`
- `nef_monitoring_subscription_test_reporting_api_port`
- `nef_monitoring_subscription_test_mini_api_endpoint_to_invoke`

Example:
- `export nef_monitoring_subscription_test_reporting_api_ip=10.255.28.173`
- `export nef_monitoring_subscription_test_reporting_api_port=3000`
- `export nef_monitoring_subscription_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G2`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Monitoring Subscription Test
==============================================================================
Nef Monitoring Subscription Test.Nef Monitoring Subscription Test
==============================================================================
NEF's Get UE Test                                                     | PASS |
Test Successful! NApp was able to subscribe a monitoring event in the  NEF
------------------------------------------------------------------------------
Nef Monitoring Subscription Test.Nef Monitoring Subscription Test     | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Monitoring Subscription Test                                      | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Monitoring Subscription Test
==============================================================================
Nef Monitoring Subscription Test.Nef Monitoring Subscription Test
==============================================================================
NEF's Get UE Test                                                     | FAIL |
"Subscription Done"
------------------------------------------------------------------------------
Nef Monitoring Subscription Test.Nef Monitoring Subscription Test     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Monitoring Subscription Test                                      | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_monitoring_subscription_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```