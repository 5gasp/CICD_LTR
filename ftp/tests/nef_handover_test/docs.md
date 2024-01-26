# NEF Handover Test

## 1. Test Goals

This test is developed to validate the effectiveness of the Network Exposure Function (NEF) in handling User Equipment (UE) handovers within our network. The primary goal is to ensure that during UE handovers, the NEF seamlessly manages and maintains continuous service quality, connectivity, and security. The test suite simulates various handover scenarios to assess the NEF's capability to adapt to dynamic network conditions and user mobility, ensuring that service experience remains consistent and reliable for users on the move. This is essential for providing high-quality network service in a mobile environment and for maintaining robust network performance and user satisfaction.

## 2. Test Description

This test will validate that a Network Application is able to subscribe and eventually retrieve information about an indicative UE handover event (servicing cell switch).

## 3. Inputs

Environment Variables that must be specified:
- `nef_ue_handover_test_reporting_api_ip`
- `nef_ue_handover_test_reporting_api_port`
- `nef_ue_handover_test_mini_api_endpoint_to_invoke`
- `nef_ue_handover_test_ue_supi`

Example:
- `export nef_ue_handover_test_reporting_api_ip=10.255.28.173`
- `export nef_ue_handover_test_reporting_api_port=3001`
- `export nef_ue_handover_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G3`
- `export nef_ue_handover_test_ue_supi=202010000000001`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Handover Test
==============================================================================
Nef Handover Test.Nef Ue Handover Test
==============================================================================
NEF's Get UE Handover Test                                            | PASS |
Test Successful! NApp was able to get an UE's handover events
------------------------------------------------------------------------------
Nef Handover Test.Nef Ue Handover Test                                | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Handover Test                                                     | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Handover Test
==============================================================================
Nef Handover Test.Nef Ue Handover Test
==============================================================================
NEF's Get UE Handover Test                                            | FAIL |
"Subscription Done"
------------------------------------------------------------------------------
Nef Handover Test.Nef Ue Handover Test                                | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Handover Test                                                     | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_handover_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```