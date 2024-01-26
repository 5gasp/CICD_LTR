# NEF UE Path Loss Test

## 1. Test Goals

The NEF UE Path Loss test is designed to assess the effectiveness of the Network Exposure Function (NEF) in accurately measuring and managing path loss for User Equipment (UE) within the network. The objective is to ensure the NEF's capability in evaluating the degradation of signal strength as it travels through the network, which is essential for optimizing network performance and ensuring reliable communication. By accurately assessing path loss, the NEF plays a crucial role in enhancing network coverage, quality of service, and the overall user experience, especially in environments with varied and challenging signal propagation conditions.

## 2. Test Description

This test will validate that a Network Application is able to retrieve indicative information about the UE RSSI subtracted from the respective radio node transmitted (path loss).

## 3. Inputs

Environment Variables that must be specified:
- `nef_ue_path_loss_test_reporting_api_ip`
- `nef_ue_path_loss_test_reporting_api_port`
- `nef_ue_path_loss_test_mini_api_endpoint_to_invoke`
- `nef_ue_path_loss_test_ue_supi`

Example:
- `export nef_ue_path_loss_test_reporting_api_ip=10.255.28.173`
- `export nef_ue_path_loss_test_reporting_api_port=3000`
- `export nef_ue_path_loss_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G5`
- `export nef_ue_path_loss_test_ue_supi=202010000000001`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Ue Path Loss Test
==============================================================================
Nef Ue Path Loss Test.Nef Ue Path Loss Test
==============================================================================
NEF's Get UE Path Loss Data Test                                      | PASS |
Test Successful! NApp was able to get an UE's path loss
------------------------------------------------------------------------------
Nef Ue Path Loss Test.Nef Ue Path Loss Test                           | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Ue Path Loss Test                                                 | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Ue Path Loss Test
==============================================================================
Nef Ue Path Loss Test.Nef Ue Path Loss Test
==============================================================================
NEF's Get UE Path Loss Data Test                                      | FAIL |
"Got UE Path Loss Information"
------------------------------------------------------------------------------
Nef Ue Path Loss Test.Nef Ue Path Loss Test                           | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Ue Path Loss Test                                                 | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_path_loss_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```