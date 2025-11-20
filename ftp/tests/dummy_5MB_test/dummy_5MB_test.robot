*** Settings ***
Library    Process
Library    dummy_5MB_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    ${test}=  Test
    Should Be True  ${test}