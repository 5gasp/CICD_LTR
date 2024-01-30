
*** Settings ***
Library        TCTest.py
Library        OperatingSystem


*** Variables ***
${availability_and_continuity_packet_loss_DurationForUE4}    36
${availability_and_continuity_packet_loss_DurationForUE5}    30
${availability_and_continuity_packet_loss_DurationForUE6}    28
${availability_and_continuity_packet_loss_DurationForUE7}    33
${availability_and_continuity_packet_loss_DurationForUE8}    33
${availability_and_continuity_packet_loss_UENumber}    6

*** Test Cases ***
Testing for UE${availability_and_continuity_packet_loss_UENumber}
    ${availability_and_continuity_packet_loss_NEFURL}=    Get Environment Variable    availability_and_continuity_packet_loss_NEFURL
    Should Not Be Empty    ${availability_and_continuity_packet_loss_NEFURL}
    Log    The NEF URL is: ${availability_and_continuity_packet_loss_NEFURL}
    ${result}=  iterateForAUE    ${availability_and_continuity_packet_loss_NEFURL}     ${availability_and_continuity_packet_loss_UENumber}   ${availability_and_continuity_packet_loss_DurationForUE4}
    IF     '${result}' != '-1'
    Should Be Equal As Strings    ${result}    Success
    ELSE
    FAIL    \nImpossible to test
    END

Uninstalling requirements
    ${output}=  Uninstall Requirements
#    Should Contain    ${output}    Success
