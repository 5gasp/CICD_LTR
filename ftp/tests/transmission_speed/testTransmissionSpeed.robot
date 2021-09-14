*** Settings ***
Library        TransmissionSpeed.py

*** Test Cases ***
Testing the transmission speed
    ${COMPARATOR}=       Run Keyword If      '%{transmission_speed_comparator}' == 'more than'        Set Variable    >
    ...    ELSE IF    '%{transmission_speed_comparator}' == 'more or equal than'        Set Variable    >=
    ...    ELSE IF    '%{transmission_speed_comparator}' == 'less than'        Set Variable    <
    ...    ELSE IF    '%{transmission_speed_comparator}' == 'less or equal than'        Set Variable    <=
    ...    ELSE     Fail  \nComparator has not been defined


    ${milliseconds}=    Transmission Speed
    
    IF     '${milliseconds}' != '-1'
    Should Be True    ${milliseconds} ${COMPARATOR} %{transmission_speed_threshold}
    ELSE
    FAIL    \nImpossible to compute transmission speed
    END