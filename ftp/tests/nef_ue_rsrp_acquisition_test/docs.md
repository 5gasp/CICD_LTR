# NEF UE RSRP Acquisition Test

## 1. Test Goals

The goal of this test is to evaluate the effectiveness of the Network Exposure Function (NEF) in acquiring and managing Reference Signal Received Power (RSRP) data for User Equipment (UE). This test ensures that the NEF can accurately gather and process RSRP information, which is crucial for assessing the signal quality experienced by mobile devices in the network. By validating this functionality, the test suite aims to confirm that the NEF contributes effectively to the network's ability to optimize signal coverage and quality for a better user experience. This is vital for maintaining high standards of network performance and reliability, especially in environments with diverse and dynamic signal conditions.

## 2. Test Description

This test will validate that a Network Application is able to retrieve indicative information about RSRP

## 3. Inputs

Environment Variables that must be specified:
- `nef_ue_rsrp_acquisition_test_reporting_api_ip`
- `nef_ue_rsrp_acquisition_test_reporting_api_port`
- `nef_ue_rsrp_acquisition_test_mini_api_endpoint_to_invoke`
- `nef_ue_rsrp_acquisition_test_ue_supi`

Example:
- `export nef_ue_rsrp_acquisition_test_reporting_api_ip=10.255.28.173`
- `export nef_ue_rsrp_acquisition_test_reporting_api_port=3001`
- `export nef_ue_rsrp_acquisition_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G4`
- `export nef_ue_rsrp_acquisition_test_ue_supi=202010000000001`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Ue Rsrp Acquisition Test
==============================================================================
Nef Ue Rsrp Acquisition Test.Nef Ue Rsrp Acquisition Test
==============================================================================
NEF's Acquisiton of UE RSRP                                           | PASS |
Test Successful! NApp was able to get an UE's RSRP
------------------------------------------------------------------------------
Nef Ue Rsrp Acquisition Test.Nef Ue Rsrp Acquisition Test             | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Ue Rsrp Acquisition Test                                          | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Ue Rsrp Acquisition Test
==============================================================================
Nef Ue Rsrp Acquisition Test.Nef Ue Rsrp Acquisition Test
==============================================================================
NEF's Acquisiton of UE RSRP                                           | FAIL |
"Got UE Path Loss Information"
------------------------------------------------------------------------------
Nef Ue Rsrp Acquisition Test.Nef Ue Rsrp Acquisition Test             | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Ue Rsrp Acquisition Test                                          | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_ue_rsrp_acquisition_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```