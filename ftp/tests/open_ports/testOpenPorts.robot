*** Settings ***
Library        OpenPorts.py
Test Timeout  25 minutes

*** Test Cases ***
Testing the open ports
    ${open_ports_status}=    Test Open Ports    %{open_ports_host}    %{open_ports_expected_open_ports}

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