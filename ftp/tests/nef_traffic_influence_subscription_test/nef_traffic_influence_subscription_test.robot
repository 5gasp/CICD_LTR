*** Settings ***
Library    nef_traffic_influence_subscription_test.py

*** Test Cases ***
NEF's Traffic Influence Test
    ${nef_traffic_influence_test_status}=  Test NEF Traffic Influence Subscription    %{nef_traffic_influence_subscription_test_mini_api_endpoint_to_invoke}    %{nef_traffic_influence_subscription_test_reporting_api_ip}    %{nef_traffic_influence_subscription_test_reporting_api_port}
    IF  '${nef_traffic_influence_test_status[0]}' in ['0']
        Pass Execution  \n${nef_traffic_influence_test_status[1]}
    ELSE IF  '${nef_traffic_influence_test_status[0]}' in ['1', '2']
        Fail  \n${nef_traffic_influence_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END