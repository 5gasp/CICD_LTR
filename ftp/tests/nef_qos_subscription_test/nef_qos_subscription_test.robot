*** Settings ***
Library    nef_qos_subscription_test.py


*** Test Cases ***
NEF's QoS Subscription Test
    ${nef_qos_subscription_test_status}=  Test NEF QoS Subscription    %{nef_qos_subscription_test_mini_api_endpoint_to_invoke}    %{nef_qos_subscription_test_reporting_api_ip}    %{nef_qos_subscription_test_reporting_api_port}
    IF  '${nef_qos_subscription_test_status[0]}' in ['0']
        Pass Execution  \n${nef_qos_subscription_test_status[1]}
    ELSE IF  '${nef_qos_subscription_test_status[0]}' in ['1', '2']
        Fail  \n${nef_qos_subscription_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END