*** Settings ***
Library    nef_serving_cell_info_test.py


*** Test Cases ***
NEF's Get UE Path Loss Data Test
    ${nef_serving_cell_info_test_status}=  Test NEF Serving Cell Info    %{nef_serving_cell_info_test_mini_api_endpoint_to_invoke}    %{nef_serving_cell_info_test_reporting_api_ip}    %{nef_serving_cell_info_test_reporting_api_port}    %{nef_serving_cell_info_test_ue_supi} 
    IF  '${nef_serving_cell_info_test_status[0]}' in ['0']
        Pass Execution  \n${nef_serving_cell_info_test_status[1]}
    ELSE IF  '${nef_serving_cell_info_test_status[0]}' in ['1', '2']
        Fail  \n${nef_serving_cell_info_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END