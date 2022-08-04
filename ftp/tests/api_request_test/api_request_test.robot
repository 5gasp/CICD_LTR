*** Settings ***
Library        api_request_test.py

*** Test Cases ***
Requesting a resource from the NetApp entities

    ${output}=    Get Resource   %{api_request_test_host}  %{api_request_test_port}  
    Should Be Equal    ${output}    Success: The entity server is ready