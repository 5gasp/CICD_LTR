*** Settings ***
Library    report_api_configuration.py


*** Test Cases ***
Create Report on Reporting API
    ${report_api_configuration_status}=  Perform Report API Configuration    %{report_api_configuration_api_ip}    %{report_api_configuration_api_port}
    IF  '${report_api_configuration_status[0]}' in ['0']
        Pass Execution  \n${report_api_configuration_status[1]}
    ELSE IF  '${report_api_configuration_status[0]}' in ['1']
        Fail  \n${report_api_configuration_status[1]}
    ELSE
        Fail  \nUnknown Error
    END