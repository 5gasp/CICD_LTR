*** Settings ***
Library    nef_monitoring_subscription_test.py


*** Test Cases ***
NEF's Get UE Test
    ${nef_monitoring_subscription_test_status}=  Test Monitoring Subscription    %{nef_monitoring_subscription_test_mini_api_endpoint_to_invoke}    %{nef_monitoring_subscription_test_reporting_api_ip}    %{nef_monitoring_subscription_test_reporting_api_port}
    IF  '${nef_monitoring_subscription_test_status[0]}' in ['0']
        Pass Execution  \n${nef_monitoring_subscription_test_status[1]}
    ELSE IF  '${nef_monitoring_subscription_test_status[0]}' in ['1', '2']
        Fail  \n${nef_monitoring_subscription_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END