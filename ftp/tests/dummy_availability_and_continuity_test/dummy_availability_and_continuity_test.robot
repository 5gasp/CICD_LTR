*** Settings ***
Library        dummy_availability_and_continuity_test.py
Test Timeout  15 minutes

*** Test Cases ***
Dummy Availability And Continuity Test
    ${dummy_availability_and_continuity_test_status}=   Dummy Test

    IF  '${dummy_availability_and_continuity_test_status[0]}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${dummy_availability_and_continuity_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${dummy_availability_and_continuity_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END