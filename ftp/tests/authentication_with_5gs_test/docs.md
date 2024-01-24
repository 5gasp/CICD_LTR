# Authentication with 5GS Test

## 1. Test Goals

The purpose of this test is to thoroughly evaluate the authentication processes within the 5G System (5GS). It aims to ensure that the authentication mechanism is secure, efficient, and complies with the latest 5G standards and specifications. The primary focus is on validating the system's ability to accurately authenticate user equipment (UE) and maintain the integrity of network security protocols. This suite plays a pivotal role in verifying the robustness of the 5G network's authentication framework, which is crucial for maintaining a secure and reliable 5G communication environment.

## 2. Test Description

This test will validate the authentication and authorization of a Network Application to use 5GS resources (NEF).

## 3. Inputs

Environment Variables that must be specified:
- `export authentication_with_5gs_test_reporting_api_ip=10.255.28.173`
- `export authentication_with_5gs_test_reporting_api_port=3001`
- `export authentication_with_5gs_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G1`

Example:
- `authentication_with_5gs_test_reporting_api_ip`
- `authentication_with_5gs_test_reporting_api_port`
- `authentication_with_5gs_test_mini_api_endpoint_to_invoke`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Authentication With 5Gs Test
==============================================================================
Authentication With 5Gs Test.Authentication With 5Gs Test
==============================================================================
NEF's Authentication Test                                             | PASS |
Test Successful! NetApp was able to authenticate with the NEF
------------------------------------------------------------------------------
Authentication With 5Gs Test.Authentication With 5Gs Test             | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Authentication With 5Gs Test                                          | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Authentication With 5Gs Test
==============================================================================
Authentication With 5Gs Test.Authentication With 5Gs Test
==============================================================================
NEF's Authentication Test                                             | FAIL |
null
------------------------------------------------------------------------------
Authentication With 5Gs Test.Authentication With 5Gs Test             | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Authentication With 5Gs Test                                          | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/authentication_with_5gs_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```