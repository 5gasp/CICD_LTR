*** Settings ***
Library        network_application_performance_rtt.py

*** Test Cases ***

Perf12 - Network Application Performance - IP Round-Trip (RTT) test

    ${output}=    Ip Ping Rtt  %{network_application_performance_rtt_target}
    Should Be True    ${output} < %{network_application_performance_rtt_threshold_ms}
    Log to console    IP RTT ${output} ms, threshold %{network_application_performance_rtt_threshold_ms}, target: %{network_application_performance_rtt_target}
