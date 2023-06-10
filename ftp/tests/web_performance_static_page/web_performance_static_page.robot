*** Settings ***
Library        web_performance_static_page.py

*** Test Cases ***

Web Performance Static Page - Network Application - Web performance static page

    ${output}=    Web Speed  %{web_performance_static_page_target}
    Should Be True    ${output}[0] > %{web_performance_static_page_web_speed_net_threshold_bps} 
    Log to console    WEB speed (net, gross) ${output} kbps, thresholds (${output}[0], ${output}[1]), target %{web_performance_static_page_target} 
