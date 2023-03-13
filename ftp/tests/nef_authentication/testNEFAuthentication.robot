*** Settings ***
Library    NEFAuthentication.py


*** Test Cases ***
Validate if NetApp is able to authenticate with the NEF
    ${nef_authentication_status}=  Test NEF Authentication    %{nef_authentication_vnf_base_api_location}    %{nef_authentication_nef_reporting_base_api_location}    %{nef_authentication_nef_ip}    %{nef_authentication_nef_port}    %{nef_authentication_nef_username}    %{nef_authentication_nef_password}

    IF  '${nef_authentication_status[0]}' in ['0']
        Pass Execution  \n${nef_authentication_status[1]}
    ELSE IF  '${nef_authentication_status[0]}' in ['1', '2']
        Fail  \n${nef_authentication_status[1]}
    ELSE
        Fail  \nUnknown Error
    END