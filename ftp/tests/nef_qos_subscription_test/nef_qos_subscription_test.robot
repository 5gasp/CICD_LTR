*** Settings ***
Library    nef_qos_subscription_test.py


*** Test Cases ***
NEF's QoS Subscription Test
    # Start by logging the test parameters/inputs
    Log    MiniAPI endpoint to invoke: %{nef_qos_subscription_test_mini_api_endpoint_to_invoke}
    Log    Reporting API IP: %{nef_qos_subscription_test_reporting_api_ip}
    Log    Reporting API Port: %{nef_qos_subscription_test_reporting_api_port}
    Log    Monitoring Payload: %{nef_qos_subscription_test_monitoring_payload}
    Run Keyword    Log to Console    \nMiniAPI endpoint to invoke: %{nef_qos_subscription_test_mini_api_endpoint_to_invoke}
    Run Keyword    Log to Console    Reporting API IP: %{nef_qos_subscription_test_reporting_api_ip}
    Run Keyword    Log to Console    Reporting API Port: %{nef_qos_subscription_test_reporting_api_port}
    Run Keyword    Log to Console    Monitoring Payload: %{nef_qos_subscription_test_monitoring_payload}\n
    # Perform the test
    ${nef_qos_subscription_test_status}=  Test NEF QoS Subscription    %{nef_qos_subscription_test_mini_api_endpoint_to_invoke}    %{nef_qos_subscription_test_reporting_api_ip}    %{nef_qos_subscription_test_reporting_api_port}    %{nef_qos_subscription_test_monitoring_payload}
    # Log the test results
    Log    Test Output: ${nef_qos_subscription_test_status}
    Run Keyword    Log to Console    \nTest Output: ${nef_qos_subscription_test_status}\n
    # Check if test should pass or fail
    IF  '${nef_qos_subscription_test_status[0]}' in ['0']
        Pass Execution  \n${nef_qos_subscription_test_status[1]}
    ELSE IF  '${nef_qos_subscription_test_status[0]}' in ['1', '2']
        Fail  \n${nef_qos_subscription_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END