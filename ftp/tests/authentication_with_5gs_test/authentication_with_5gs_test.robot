*** Settings ***
Library    authentication_with_5gs_test.py


*** Test Cases ***
NEF's Authentication Test
    ${authentication_with_5gs_test_status}=  Test NEF Authentication    %{authentication_with_5gs_test_mini_api_endpoint_to_invoke}    %{authentication_with_5gs_test_reporting_api_ip}    %{authentication_with_5gs_test_reporting_api_port}
    IF  '${authentication_with_5gs_test_status[0]}' in ['0']
        Pass Execution  \n${authentication_with_5gs_test_status[1]}
    ELSE IF  '${authentication_with_5gs_test_status[0]}' in ['1', '2']
        Fail  \n${authentication_with_5gs_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END