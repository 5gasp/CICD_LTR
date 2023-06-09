*** Settings ***
Library        performance.py

*** Test Cases ***

Perf9 - Network Application - API performance - response time

    ${output}=    Response Time  %{perf9_api_target}
    Should Be True    ${output} < %{perf9_api_target_threshold_s}
    Log to console    Response Time ${output} s, threshold %{perf9_api_target_threshold_s}, target: %{perf9_api_target}
