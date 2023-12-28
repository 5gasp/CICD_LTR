*** Settings ***
Library    nef_ue_handover_test.py


*** Test Cases ***
NEF's Get UE Path Loss Data Test
    ${nef_ue_handover_test_status}=  Test NEF UE Handover    %{nef_ue_handover_test_mini_api_endpoint_to_invoke}    %{nef_ue_handover_test_reporting_api_ip}    %{nef_ue_handover_test_reporting_api_port}    %{nef_ue_handover_test_ue1_supi} 
    IF  '${nef_ue_handover_test_status[0]}' in ['0']
        Pass Execution  \n${nef_ue_handover_test_status[1]}
    ELSE IF  '${nef_ue_handover_test_status[0]}' in ['1', '2']
        Fail  \n${nef_ue_handover_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END