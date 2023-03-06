*** Settings ***
Library    SshAudit.py

*** Test Cases ***
Performing ssh audit
    ${ssh_audit_status}=  Test Ssh Audit    %{ssh_audit_ssh_host}    %{ssh_audit_ssh_port}

    IF  '${ssh_audit_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${ssh_audit_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${ssh_audit_status[1]}
    ELSE
        Fail  \nUnknown Error
    END
