# NEF Authentication Test

## 1. Test Goals

This test is specifically designed to evaluate the authentication processes of our Network Exposure Function (NEF). Its primary aim is to ensure the NEF's authentication mechanisms are not only robust and secure but also effectively manage and control access to network capabilities and services. The suite tests various authentication scenarios to guarantee that NEF adheres to our strict security protocols and standards, thus maintaining the integrity and reliability of network interactions. This is vital for protecting the network from unauthorized access and ensuring secure communication between different network elements and services.

## 2. Test Description

Validate if a Network Application is able to authenticate with the NEF before making any requests.

## 3. Inputs

Environment Variables that must be specified:
- `nef_authentication_test_reporting_api_ip`
- `nef_authentication_test_reporting_api_port`
- `nef_authentication_test_mini_api_endpoint_to_invoke`

Example:
- `export nef_authentication_test_reporting_api_ip=10.255.28.173`
- `export nef_authentication_test_reporting_api_port=3000`
- `export nef_authentication_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def19Sec9`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Authentication Test
==============================================================================
Nef Authentication Test.Nef Authentication Test
==============================================================================
NEF's Authentication Test                                             | PASS |
Test Successful! NetApp was able to authenticate with the NEF
------------------------------------------------------------------------------
Nef Authentication Test.Nef Authentication Test                       | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Authentication Test                                               | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Authentication Test
==============================================================================
Nef Authentication Test.Nef Authentication Test
==============================================================================
NEF's Authentication Test                                             | FAIL |
"Login Done"
------------------------------------------------------------------------------
Nef Authentication Test.Nef Authentication Test                       | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Authentication Test                                               | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_authentication_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```