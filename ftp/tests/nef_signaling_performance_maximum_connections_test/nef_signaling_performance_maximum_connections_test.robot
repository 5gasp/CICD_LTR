*** Settings ***
Library    Process
Library    nef_signaling_performance_maximum_connections_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Load Test Host: %{nef_signaling_performance_maximum_connections_test_load_test_host}
    Log    Load Test endpoint: %{nef_signaling_performance_maximum_connections_test_load_test_endpoint}
    Run Keyword    Log To Console    \n\Load Test Host: %{nef_signaling_performance_maximum_connections_test_load_test_host}
    Run Keyword    Log To Console    \nLoad Test  endpoint: %{nef_signaling_performance_maximum_connections_test_load_test_endpoint}
    # Start the test in the MiniAPI
    ${mini_api_test_started}=  Start Mini Api Test    %{nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_test_started}
    # Afer this we will have to generate some load, to evaluate how many
    # connections does the Network Application Handle.
    # This Locust Process will spwan 100 users at once and will try to make
    # requests to the target during 20 seconds. These user are used to generat
    # TCP connections with one of the Networok Application's API
    ${output}=    Run Process   locust    -f    locust_performance_test.py    --headless    -u    25    -r    25    --run-time    20    --host    %{nef_signaling_performance_maximum_connections_test_load_test_host}    --endpoint    %{nef_signaling_performance_maximum_connections_test_load_test_endpoint}    --json
    Log    ${output.stdout} 
    Run Keyword    Log To Console    \nLocust Output:\n ${output.stdout}
    # Now we can stop the test
    ${mini_api_test_stopped}=  Stop Mini Api Test    %{nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup}
    # Check if the test was stopped in the MiniAPI
    Should Be True  ${mini_api_test_stopped}
    # Now we must invoke the /results endpoint of the MiniAPI to get the test
    # outcomes and evaluate them
    ${maximum_achieved_connections}=  Get Results And Evaluate Them    %{nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results}
    Log    \nMaximum Number Of Connections: ${maximum_achieved_connections}
    Run Keyword    Log To Console   \nMaximum Number Of Connections: ${maximum_achieved_connections}
    # Now, we have to evaluate the results agains the minimum threshold for
    # the number concurrent connections
    IF    ${maximum_achieved_connections} >= %{nef_signaling_performance_maximum_connections_test_connections_minimum_threshold}
        Pass Execution    \n\nThe Target Server/API COMPLIES with the minimum threshold set for number of concurrent connections (%{nef_signaling_performance_maximum_connections_test_connections_minimum_threshold}).\n
    ELSE
        Fail  \n\nThe Target Server/API DOES NOT comply with the minimum threshold set for number of concurrent connections(%{nef_signaling_performance_maximum_connections_test_connections_minimum_threshold}).\n
    END
