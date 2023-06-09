*** Settings ***
Library        performance.py

*** Test Cases ***

Perf8 - Network Application - Web performance static page

    ${output}=    Web Speed  %{perf8_web_target}
    Should Be True    ${output}[0] > %{perf8_web_speed_net_threshold_bps} 
    Log to console    WEB speed (net, gross) ${output} kbps, thresholds (%{perf8_web_speed_net_threshold_bps}, %{perf8_web_speed_gross_threshold_bps}), target %{perf8_web_target} 
