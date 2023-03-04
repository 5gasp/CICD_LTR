*** Settings ***
Library    SshAudit.py

*** Test Cases ***
performing ssh audit
    ${ssh_audit_status}=  perform    %{ssh_host}    %{ssh_port}

    IF  '${ssh_audit_status}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${ssh_audit_status}' == '1'
        Fail  \nInputs were wrongly defined
    ELSE IF  '${ssh_audit_status}' == '2'
        Fail  \n The audit has presented warnings
    ELSE IF  '${ssh_audit_status}' == '3'
        Fail  \nThe audit has failed
    ELSE IF  '${ssh_audit_status}' == '4'
        Fail  \nHost is not accessible
    ELSE
        Fail  \nUnknown Error
    END
