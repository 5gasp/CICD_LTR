*** Settings ***
Library    nef_ue_rsrp_acquisition_test.py


*** Test Cases ***
NEF's Acquisiton of UE RSRP
    ${nef_ue_rsrp_acquisition_test_status}=  Test NEF Acquisiton of UE RSRP    %{nef_ue_rsrp_acquisition_test_mini_api_endpoint_to_invoke}    %{nef_ue_rsrp_acquisition_test_reporting_api_ip}    %{nef_ue_rsrp_acquisition_test_reporting_api_port}    %{nef_ue_rsrp_acquisition_test_ue_supi} 
    IF  '${nef_ue_rsrp_acquisition_test_status[0]}' in ['0']
        Pass Execution  \n${nef_ue_rsrp_acquisition_test_status[1]}
    ELSE IF  '${nef_ue_rsrp_acquisition_test_status[0]}' in ['1', '2']
        Fail  \n${nef_ue_rsrp_acquisition_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END