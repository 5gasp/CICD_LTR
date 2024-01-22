*** Settings ***
Library        api_performance_response_time.py

*** Test Cases ***

API Performance Response Time - Network Application - API performance - Response Time

    ${output}=    Response Time  %{api_performance_response_time_api_target}
    Should Be True    ${output} < %{api_performance_response_time_threshold_ms}
    Log to console    Response Time ${output} s, threshold %{api_performance_response_time_threshold_ms}, target: %{api_performance_response_time_api_target}
