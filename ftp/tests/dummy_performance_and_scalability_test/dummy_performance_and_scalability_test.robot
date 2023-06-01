*** Settings ***
Library        dummy_performance_and_scalability_test.py
Test Timeout  15 minutes

*** Test Cases ***
Dummy Performance and Scalability Test
    ${dummy_performance_and_scalability_test_status}=   Dummy Test

    IF  '${dummy_performance_and_scalability_test_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${dummy_performance_and_scalability_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${dummy_performance_and_scalability_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END