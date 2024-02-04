*** Settings ***
Library    mini_api_configuration.py


*** Test Cases ***
Configure the Mini API
    ${mini_api_configuration_status}=  Perform Mini API Configuration    %{mini_api_configuration_configuration_endpoint}    %{mini_api_configuration_configuration_payload}
    IF  '${mini_api_configuration_status[0]}' in ['0']
        Pass Execution  \n${mini_api_configuration_status[1]}
    ELSE IF  '${mini_api_configuration_status[0]}' in ['1']
        Fail  \n${mini_api_configuration_status[1]}
    ELSE
        Fail  \nUnknown Error
    END