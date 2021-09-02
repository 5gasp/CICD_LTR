*** Settings ***
Library        TransmissionSpeed.py

*** Test Cases ***
Testing the transmission speed between OBU and vOBU

    ${milliseconds}=    Transmission Speed
    Should Be Equal    ${milliseconds}    Less than 500 milliseconds
