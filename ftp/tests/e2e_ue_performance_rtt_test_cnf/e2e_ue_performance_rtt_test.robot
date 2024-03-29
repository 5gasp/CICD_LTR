*** Settings ***
Library    e2e_ue_performance_rtt_test.py


*** Test Cases ***
E2E UE Performance Test
    ${e2e_ue_performance_rtt_test_status}=  Test E2E UE Performance    %{e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke}   %{e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_results}    %{e2e_ue_performance_rtt_test_mini_api_endpoint_to_invoke_cleanup}    %{e2e_ue_performance_rtt_test_threshold}
    IF  '${e2e_ue_performance_rtt_test_status[0]}' in ['0']
        Pass Execution  \n${e2e_ue_performance_rtt_test_status[1]}
    ELSE IF  '${e2e_ue_performance_rtt_test_status[0]}' in ['1', '2']
        Fail  \n${e2e_ue_performance_rtt_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END