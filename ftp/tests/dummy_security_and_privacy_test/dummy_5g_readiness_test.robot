*** Settings ***
Library        dummy_security_and_privacy_test.py
Test Timeout  15 minutes

*** Test Cases ***
Dummy Security And Privacy Test
    ${dummy_security_and_privacy_test_status}=   Dummy Test

    IF  '${dummy_security_and_privacy_test_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${dummy_security_and_privacy_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${dummy_security_and_privacy_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END