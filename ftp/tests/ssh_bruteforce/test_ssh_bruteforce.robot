*** Settings ***
Library    ssh_bruteforce.py


*** Test Cases ***
Performing ssh bruteforce
    ${ssh_bruteforce_status}=  Ssh Bruteforce    %{ssh_bruteforce_user}  %{ssh_bruteforce_passfile}  %{ssh_bruteforce_host}

    IF  '${ssh_bruteforce_status[0]}' in ['1', '3']
        Pass Execution  \n${ssh_bruteforce_status[1]}
    ELSE IF  '${ssh_bruteforce_status[0]}' in ['2', '4']
        Fail  \n${ssh_bruteforce_status[1]}
    ELSE
        Fail  \nUnknown Error
    END