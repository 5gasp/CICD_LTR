*** Settings ***
Library    nef_create_ue_test.py


*** Test Cases ***
NEF's Create UE Test
    ${nef_create_ue_test_status}=  Test NEF Create UE    %{nef_create_ue_test_mini_api_endpoint_to_invoke}    %{nef_create_ue_test_reporting_api_ip}    %{nef_create_ue_test_reporting_api_port}
    IF  '${nef_create_ue_test_status[0]}' in ['0']
        Pass Execution  \n${nef_create_ue_test_status[1]}
    ELSE IF  '${nef_create_ue_test_status[0]}' in ['1', '2']
        Fail  \n${nef_create_ue_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END