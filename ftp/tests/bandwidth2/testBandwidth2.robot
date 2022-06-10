*** Settings ***
Library        Bandwidth2.py

*** Test Cases ***
Testing if the bandwidth is %{bandwidth_comparator} %{bandwidth_threshold} mbits/sec
    ${COMPARATOR}=       Run Keyword If      '%{bandwidth_comparator}' == 'more_than'        Set Variable    >
    ...    ELSE IF    '%{bandwidth_comparator}' == 'more_or_equal_than'        Set Variable    >=
    ...    ELSE IF    '%{bandwidth_comparator}' == 'less_than'        Set Variable    <
    ...    ELSE IF    '%{bandwidth_comparator}' == 'less_or_equal_than'        Set Variable    <=
    ...    ELSE     Fail  \nComparator has not been defined


    ${mbits_sec}=    Bandwidth2
    IF     '${mbits_sec}' != '-1'
    Should Be True    ${mbits_sec} ${COMPARATOR} %{bandwidth_threshold}
    ELSE
    FAIL    \nImpossible to compute bandwidth
    END