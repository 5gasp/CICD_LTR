*** Settings ***
Library        SSHBruteforce.py
Test Timeout  30 minutes

*** Test Cases ***
Brute force SSH Credentials Test
    ${ssh_brute_force_test_status}=    SSH Brute Force Test    %{ssh_brute_force_username=NONE}    %{ssh_brute_force_max_password_to_test=NONE}    %{ssh_brute_force_max_usernames_to_test=NONE}    %{ssh_brute_force_target_ip=NONE}    %{ssh_brute_force_target_port=22}

    IF  '${ssh_brute_force_test_status[0]}' == '0'
        Pass Execution  \n${ssh_brute_force_test_status[1]}
    ELSE IF  '${ssh_brute_force_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${ssh_brute_force_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END