*** Settings ***
Library        OpenPorts.py

*** Test Cases ***
Testing the open ports

    ${open_ports_status}=    Open Ports

    IF  '${open_ports_status}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${open_ports_status}' == '1'
        Fail  \nInputs were wrongly defined
    ELSE IF  '${open_ports_status}' == '2'
        Fail  \nCould not scan the host open ports
    ELSE IF  '${open_ports_status}' == '3'
        Fail  \nThe open ports are not the ones expected
    ELSE
        Fail  \nUnknown Error
    END