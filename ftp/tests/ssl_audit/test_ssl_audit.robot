*** Settings ***
Library    ssl_audit.py


*** Test Cases ***
Performing ssl audit
    ${ssl_audit_status}=  Ssl Audit    %{ssl_audit_url}

    IF  '${ssl_audit_status[0]}' in ['0', '1']
        Pass Execution  \n${ssl_audit_status[1]}
    ELSE IF  '${ssl_audit_status[0]}' in ['2', '3']
        Fail  \n${ssl_audit_status[1]}
    ELSE
        Fail  \nUnknown Error
    END