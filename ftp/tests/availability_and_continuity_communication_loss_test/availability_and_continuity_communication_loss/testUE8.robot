
*** Settings ***
Library        ../TCTest.py
Library        OperatingSystem


*** Variables ***
${DurationForUE4}    36
${DurationForUE5}    30
${DurationForUE6}    28
${DurationForUE7}    33
${DurationForUE8}    33
${UENumber}   8
${NEFURL}   http://10.10.10.20:8888


*** Test Cases ***
Testing for UE8
    ${result}=  iterateForAUE    ${NEFURL}     ${UENumber}   ${DurationForUE8}
    IF     '${result}' != '-1'
    Should Be Equal As Strings    ${result}    Success
    ELSE
    FAIL    \nImpossible to test
    END

Uninstalling requirements
    ${output}=  Uninstall Requirements
    Should Contain    ${output}    Success