*** Settings ***
Library        Bandwidth.py

*** Test Cases ***
Testing if the bandwidth is %{bandwidth_comparator} %{bandwidth_threshold} mbits/sec
    ${COMPARATOR}=       Run Keyword If      '%{bandwidth_comparator}' == 'more than'        Set Variable    >
    ...    ELSE IF    '%{bandwidth_comparator}' == 'more or equal than'        Set Variable    >=
    ...    ELSE IF    '%{bandwidth_comparator}' == 'less than'        Set Variable    <
    ...    ELSE IF    '%{bandwidth_comparator}' == 'less or equal than'        Set Variable    <=
    ...    ELSE     Fail  \nComparator has not been defined


    ${mbits_sec}=    Bandwidth
    IF     '${mbits_sec}' != '-1'
    Should Be True    ${mbits_sec} ${COMPARATOR} %{bandwidth_threshold}
    ELSE
    FAIL    \nImpossible to compute bandwidth
    END