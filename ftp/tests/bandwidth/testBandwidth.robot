*** Settings ***
Library        Bandwidth.py

*** Test Cases ***
Testing the transmission speed between OBU and vOBU

    ${MB_sec}=    Bandwidth
    Should Be Equal    ${MB_sec}    The bandwidth is bigger than 0.1 MB/sec
