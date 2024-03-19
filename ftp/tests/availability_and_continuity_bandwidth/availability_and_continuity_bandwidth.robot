
*** Settings ***
Library        TCTest.py
Library        OperatingSystem


*** Variables ***
${availability_and_continuity_bandwidth_DurationForUE4}    36
${availability_and_continuity_bandwidth_DurationForUE5}    30
${availability_and_continuity_bandwidth_DurationForUE6}    28
${availability_and_continuity_bandwidth_DurationForUE7}    33
${availability_and_continuity_bandwidth_DurationForUE8}    33
${availability_and_continuity_bandwidth_UENumber}    4

*** Test Cases ***
Testing for UE${availability_and_continuity_bandwidth_UENumber}
    ${availability_and_continuity_bandwidth_NEFURL}=    Get Environment Variable    availability_and_continuity_bandwidth_NEFURL
    ${availability_and_continuity_bandwidth_NEFUSERNAME}=    Get Environment Variable    availability_and_continuity_bandwidth_NEFUSERNAME
    ${availability_and_continuity_bandwidth_NEFPASSWORD}=    Get Environment Variable    availability_and_continuity_bandwidth_NEFPASSWORD
    ${availability_and_continuity_bandwidth_LIVENESS}=    Get Environment Variable    availability_and_continuity_bandwidth_LIVENESS
    Should Not Be Empty    ${availability_and_continuity_bandwidth_NEFURL}
    Log    The NEF URL is: ${availability_and_continuity_bandwidth_NEFURL}
    Should Not Be Empty    ${availability_and_continuity_bandwidth_NEFUSERNAME}
    Log    The NEF USERNAME is: ${availability_and_continuity_bandwidth_NEFUSERNAME}
    Should Not Be Empty    ${availability_and_continuity_bandwidth_NEFPASSWORD}
    Log    The NEF PASSWORD is: ${availability_and_continuity_bandwidth_NEFPASSWORD}
    Should Not Be Empty    ${availability_and_continuity_bandwidth_LIVENESS}
    Log    The LIVENESS ENDPOINT is: ${availability_and_continuity_bandwidth_LIVENESS}
    ${result}=  iterateForAUE    ${availability_and_continuity_bandwidth_NEFURL}    ${availability_and_continuity_bandwidth_NEFUSERNAME}    ${availability_and_continuity_bandwidth_NEFPASSWORD}    ${availability_and_continuity_bandwidth_UENumber}    ${availability_and_continuity_bandwidth_DurationForUE4}    ${availability_and_continuity_bandwidth_LIVENESS}
    IF     '${result}' != '-1'
    Should Be Equal As Strings    ${result}    Success
    ELSE
    FAIL    \nImpossible to test
    END

Uninstalling requirements
    ${output}=  Uninstall Requirements
#    Should Contain    ${output}    Success