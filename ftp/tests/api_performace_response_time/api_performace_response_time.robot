*** Settings ***
Library        api_performace_response_time.py

*** Test Cases ***

API Performance Response Time - Network Application - API performance - Response Time

    ${output}=    Response Time  %{api_performace_response_time_api_target}
    Should Be True    ${output} < %{api_performace_response_time_threshold_ms}
    Log to console    Response Time ${output} s, threshold %{api_performace_response_time_threshold_ms}, target: %{api_performace_response_time_api_target}
