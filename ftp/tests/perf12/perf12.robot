*** Settings ***
Library        performance.py

*** Test Cases ***

Perf12 - Network Application - IP round-trip (RTT) test

    ${output}=    Ip Ping Rtt  %{perf12_ip_rtt_target}
    Should Be True    ${output} < %{perf12_ip_rtt_threshold_ms}
    Log to console    IP RTT ${output} ms, threshold %{perf12_ip_rtt_threshold_ms}, target: %{perf12_ip_rtt_target}
