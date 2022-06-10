*** Settings ***
Library        Bandwidth2.py

*** Test Cases ***
Testing if the bandwidth is %{bandwidth2_comparator} %{bandwidth2_threshold} mbits/sec
    ${COMPARATOR}=       Run Keyword If      '%{bandwidth2_comparator}' == 'more_than'        Set Variable    >
    ...    ELSE IF    '%{bandwidth2_comparator}' == 'more_or_equal_than'        Set Variable    >=
    ...    ELSE IF    '%{bandwidth2_comparator}' == 'less_than'        Set Variable    <
    ...    ELSE IF    '%{bandwidth2_comparator}' == 'less_or_equal_than'        Set Variable    <=
    ...    ELSE     Fail  \nComparator has not been defined


    ${mbits_sec}=    Bandwidth2
    IF     '${mbits_sec}' != '-1'
    Should Be True    ${mbits_sec} ${COMPARATOR} %{bandwidth2_threshold}
    ELSE
    FAIL    \nImpossible to compute bandwidth
    END