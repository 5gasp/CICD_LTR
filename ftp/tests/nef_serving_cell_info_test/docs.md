# NEF Servicing Cell Info Test

## 1. Test Goals

This test aims to evaluate the Network Exposure Function's (NEF's) capability in accurately obtaining and managing information about the serving cell in a mobile network. The primary objective is to ensure that NEF effectively processes and responds to data regarding the cell currently serving a User Equipment (UE). This involves assessing the NEF's proficiency in handling key information such as cell identification, signal strength, and quality metrics. The suite is essential in verifying that NEF contributes significantly to the network's ability to optimize resource allocation, enhance user experience, and maintain seamless connectivity, especially in dynamic network environments where UE frequently switch between cells.

## 2. Test Description

This test will validate that a Network Application is able to retrieve indicative information about the serving radio node (cell).

## 3. Inputs

Environment Variables that must be specified:
nef_serving_cell_info_test_reporting_api_ip
nef_serving_cell_info_test_reporting_api_port
nef_serving_cell_info_test_mini_api_endpoint_to_invoke
nef_serving_cell_info_test_ue_supi

Example:
- `export nef_serving_cell_info_test_reporting_api_ip=10.255.28.173`
- `export nef_serving_cell_info_test_reporting_api_port=3001`
- `export nef_serving_cell_info_test_mini_api_endpoint_to_invoke=http://10.255.28.206:8000/start/Def115G6`
- `export nef_serving_cell_info_test_ue_supi=202010000000001`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Nef Serving Cell Info Test
==============================================================================
Nef Serving Cell Info Test.Nef Serving Cell Info Test
==============================================================================
NEF's Get UE Path Loss Data Test                                      | PASS |
Test Successful! NApp was able to get UE's Serving Cell Information
------------------------------------------------------------------------------
Nef Serving Cell Info Test.Nef Serving Cell Info Test                 | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Nef Serving Cell Info Test                                            | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Nef Serving Cell Info Test
==============================================================================
Nef Serving Cell Info Test.Nef Serving Cell Info Test
==============================================================================
NEF's Get UE Path Loss Data Test                                      | FAIL |
"Got UE RSRP Information"
------------------------------------------------------------------------------
Nef Serving Cell Info Test.Nef Serving Cell Info Test                 | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Nef Serving Cell Info Test                                            | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/nef_serving_cell_info_test/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```