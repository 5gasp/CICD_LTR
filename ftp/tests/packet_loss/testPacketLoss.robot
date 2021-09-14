*** Settings ***
Library        PacketLoss.py

*** Test Cases ***
Testing the packet loss percentage
    ${COMPARATOR}=       Run Keyword If      '%{packet_loss_comparator}' == 'more than'        Set Variable    >
    ...    ELSE IF    '%{packet_loss_comparator}' == 'more or equal than'        Set Variable    >=
    ...    ELSE IF    '%{packet_loss_comparator}' == 'less than'        Set Variable    <
    ...    ELSE IF    '%{packet_loss_comparator}' == 'less or equal than'        Set Variable    <=
    ...    ELSE     Fail  \nComparator has not been defined


    ${loss_percentage}=    Packet Loss
    
    IF     '${loss_percentage}' != '-1'
    Should Be True    ${loss_percentage} ${COMPARATOR} %{packet_loss_threshold}
    ELSE
    FAIL    \nImpossible to compute packet loss percentage
    END