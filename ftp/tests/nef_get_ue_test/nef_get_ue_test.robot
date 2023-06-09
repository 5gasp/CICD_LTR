*** Settings ***
Library    nef_get_ue_test.py


*** Test Cases ***
NEF's Get UE Test
    ${nef_get_ue_test_status}=  Test NEF Get UE    %{nef_get_ue_test_mini_api_endpoint_to_invoke}    %{nef_get_ue_test_reporting_api_ip}    %{nef_get_ue_test_reporting_api_port}
    IF  '${nef_get_ue_test_status[0]}' in ['0']
        Pass Execution  \n${nef_get_ue_test_status[1]}
    ELSE IF  '${nef_get_ue_test_status[0]}' in ['1', '2']
        Fail  \n${nef_get_ue_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END