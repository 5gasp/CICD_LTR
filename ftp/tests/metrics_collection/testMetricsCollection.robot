*** Settings ***
Library        MetricsCollection.py

*** Test Cases ***
Execute the metrics collection mechanism

    ${metrics_collection_status}=    Main

    IF  '${metrics_collection_status}' == '0'
        Pass Execution  \nSuccess
    ELSE IF  '${metrics_collection_status}' == '1'
        Fail  \nCannot connect to the SSH Server
    ELSE IF  '${metrics_collection_status}' == '2'
        Fail  \nCannot transfer files via SCP
    ELSE IF  '${metrics_collection_status}' == '3'
        Fail  \nCannot move the files to their correct location
    ELSE IF  '${metrics_collection_status}' == '4'
        Fail  \nCCannot start telegraf's service
    ELSE IF  '${metrics_collection_status}' == '5'
        Fail  \nTelegraf's service was started with errors
    ELSE IF  '${metrics_collection_status}' == '6'
        Fail  \nCannot stop telegraf's service
    ELSE
        Fail  \nUnknown Error
    END