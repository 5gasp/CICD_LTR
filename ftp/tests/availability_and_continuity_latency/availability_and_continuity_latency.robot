
*** Settings ***
Library        TCTest.py
Library        OperatingSystem


*** Variables ***
${availability_and_continuity_latency_DurationForUE4}    36
${availability_and_continuity_latency_DurationForUE5}    30
${availability_and_continuity_latency_DurationForUE6}    28
${availability_and_continuity_latency_DurationForUE7}    33
${availability_and_continuity_latency_DurationForUE8}    33
${availability_and_continuity_latency_UENumber}    5

*** Test Cases ***
Testing for UE${availability_and_continuity_latency_UENumber}
    ${availability_and_continuity_latency_NEFURL}=    Get Environment Variable    availability_and_continuity_latency_NEFURL
    ${availability_and_continuity_latency_NEFUSERNAME}=    Get Environment Variable    availability_and_continuity_latency_NEFUSERNAME
    ${availability_and_continuity_latency_NEFPASSWORD}=    Get Environment Variable    availability_and_continuity_latency_NEFPASSWORD
    ${availability_and_continuity_latency_LIVENESS}=    Get Environment Variable    availability_and_continuity_latency_LIVENESS
    Should Not Be Empty    ${availability_and_continuity_latency_NEFURL}
    Log    The NEF URL is: ${availability_and_continuity_latency_NEFURL}
    Should Not Be Empty    ${availability_and_continuity_latency_NEFUSERNAME}
    Log    The NEF USERNAME is: ${availability_and_continuity_latency_NEFUSERNAME}
    Should Not Be Empty    ${availability_and_continuity_latency_NEFPASSWORD}
    Log    The NEF PASSWORD is: ${availability_and_continuity_latency_NEFPASSWORD}
    Should Not Be Empty    ${availability_and_continuity_latency_LIVENESS}
    Log    The LIVENESS ENDPOINT is: ${availability_and_continuity_latency_LIVENESS}
    ${result}=  iterateForAUE    ${availability_and_continuity_latency_NEFURL}    ${availability_and_continuity_latency_NEFUSERNAME}    ${availability_and_continuity_latency_NEFPASSWORD}    ${availability_and_continuity_latency_UENumber}    ${availability_and_continuity_latency_DurationForUE4}    ${availability_and_continuity_latency_LIVENESS}
    IF     '${result}' != '-1'
    Should Be Equal As Strings    ${result}    Success
    ELSE
    FAIL    \nImpossible to test
    END

Uninstalling requirements
    ${output}=  Uninstall Requirements
#    Should Contain    ${output}    Success