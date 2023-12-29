*** Settings ***
Library    Process
Library    maximum_number_of_connections_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Load Test Host: %{maximum_number_of_connections_test_load_test_host}
    Log    Load Test endpoint: %{maximum_number_of_connections_test_load_test_endpoint}
    Log    Load Test HTTP Method: %{maximum_number_of_connections_test_load_test_http_method}
    Run Keyword    Log To Console    \n\Load Test Host: %{maximum_number_of_connections_test_load_test_host}
    Run Keyword    Log To Console    \nLoad Test  endpoint: %{maximum_number_of_connections_test_load_test_endpoint}
    Run Keyword    Log To Console    \nLoad Test  HTTP Method: %{maximum_number_of_connections_test_load_test_http_method}
    # Start the test in the MiniAPI
    ${mini_api_test_started}=  Start Mini Api Test    %{maximum_number_of_connections_test_mini_api_endpoint_to_invoke}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_test_started}
    # Afer this we will have to generate some load, to evaluate how many
    # connections does the Network Application Handle.
    # This Locust Process will spwan 100 users at once and will try to make
    # requests to the target during 20 seconds. These user are used to generat
    # TCP connections with one of the Networok Application's API
    ${output}=    Run Process   locust    -f    locust_performance_test.py    --headless    -u    100    -r    50    --run-time    20    --host    %{maximum_number_of_connections_test_load_test_host}    --endpoint    %{maximum_number_of_connections_test_load_test_endpoint}    --http-method    %{maximum_number_of_connections_test_load_test_http_method}    --json
    Log    ${output.stdout} 
    Run Keyword    Log To Console    \nLocust Output:\n ${output.stdout}
    # Now we can stop the test
    ${mini_api_test_stopped}=  Stop Mini Api Test    %{maximum_number_of_connections_test_mini_api_endpoint_to_invoke_cleanup}
    # Check if the test was stopped in the MiniAPI
    Should Be True  ${mini_api_test_stopped}
    # Now we must invoke the /results endpoint of the MiniAPI to get the test
    # outcomes and evaluate them
    ${maximum_achieved_connections}=  Get Results And Evaluate Them    %{maximum_number_of_connections_test_mini_api_endpoint_to_invoke_results}
    Log    \nMaximum Number Of Connections: ${maximum_achieved_connections}
    Run Keyword    Log To Console   \nMaximum Number Of Connections: ${maximum_achieved_connections}
    # Now, we have to evaluate the results agains the minimum threshold for
    # the number concurrent connections
    IF    ${maximum_achieved_connections} >= %{maximum_number_of_connections_test_connections_minimum_threshold}
        Pass Execution    \n\nThe Target Server/API COMPLIES with the minimum threshold set for number of concurrent connections (%{maximum_number_of_connections_test_connections_minimum_threshold}).\n
    ELSE
        Fail  \n\nThe Target Server/API DOES NOT comply with the minimum threshold set for number of concurrent connections(%{maximum_number_of_connections_test_connections_minimum_threshold}).\n
    END
