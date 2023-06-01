*** Settings ***
Library        dummy_5g_readiness_test.py
Test Timeout  15 minutes

*** Test Cases ***
Dummy 5G Readiness Test
    ${dummy_5g_readiness_test_status}=   Dummy Test

    IF  '${dummy_5g_readiness_test_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${dummy_5g_readiness_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${dummy_5g_readiness_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END