*** Settings ***
Library        obu_data_consumption_test.py
Test Timeout  30 minutes

*** Test Cases ***
Validate OBU Data Consumption

    ${output}=    Get Available Car Plate   %{obu_data_consumption_test_desired_car_plate}   %{obu_data_consumption_test_aggregator_host}  %{obu_data_consumption_test_aggregator_port}  
    Should Contain    ${output}    Success

    ${output}=    Simulate Obu Data     %{obu_data_consumption_test_manager_host}
    Should Contain    ${output}    Success

    ${output}=    Get Obu Attributes    %{obu_data_consumption_test_aggregator_host}  %{obu_data_consumption_test_aggregator_port} 
    Should Contain    ${output}    Success