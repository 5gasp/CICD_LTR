
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
    Should Not Be Empty    ${availability_and_continuity_latency_NEFURL}
    Log    The NEF URL is: ${availability_and_continuity_latency_NEFURL}
    ${result}=  iterateForAUE    ${availability_and_continuity_latency_NEFURL}     ${availability_and_continuity_latency_UENumber}   ${availability_and_continuity_latency_DurationForUE4}
    IF     '${result}' != '-1'
    Should Be Equal As Strings    ${result}    Success
    ELSE
    FAIL    \nImpossible to test
    END

Uninstalling requirements
    ${output}=  Uninstall Requirements
#    Should Contain    ${output}    Success