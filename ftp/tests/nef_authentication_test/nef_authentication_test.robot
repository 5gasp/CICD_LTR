*** Settings ***
Library    nef_authentication_test.py


*** Test Cases ***
NEF's Authentication Test
    ${nef_authentication_test_status}=  Test NEF Authentication    %{nef_authentication_test_mini_api_endpoint_to_invoke}    %{nef_authentication_test_reporting_api_ip}    %{nef_authentication_test_reporting_api_port}
    IF  '${nef_authentication_test_status[0]}' in ['0']
        Pass Execution  \n${nef_authentication_test_status[1]}
    ELSE IF  '${nef_authentication_test_status[0]}' in ['1', '2']
        Fail  \n${nef_authentication_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END