*** Settings ***
Library    SshAudit.py


*** Test Cases ***
Performing ssh audit
    ${ssh_audit_status}=  Test Ssh Audit    %{ssh_audit_ssh_host}    %{ssh_audit_ssh_port=22}

    IF  '${ssh_audit_status[0]}' in ['0', '1']
        Pass Execution  \n${ssh_audit_status[1]}
    ELSE IF  '${ssh_audit_status[0]}' in ['2', '3']
        Fail  \n${ssh_audit_status[1]}
    ELSE
        Fail  \nUnknown Error
    END
