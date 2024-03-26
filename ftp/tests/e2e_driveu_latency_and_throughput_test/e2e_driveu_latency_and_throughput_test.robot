*** Settings ***
Library    Process
Library    e2e_driveu_latency_and_throughput_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    #Log    Load Test Host: %{maximum_number_of_connections_test_load_test_host}
    #Log    Load Test endpoint: %{maximum_number_of_connections_test_load_test_endpoint}
    #Log    Load Test HTTP Method: %{maximum_number_of_connections_test_load_test_http_method}
    #Run Keyword    Log To Console    \n\Load Test Host: %{maximum_number_of_connections_test_load_test_host}
    #Run Keyword    Log To Console    \nLoad Test  endpoint: %{maximum_number_of_connections_test_load_test_endpoint}
    #Run Keyword    Log To Console    \nLoad Test  HTTP Method: %{maximum_number_of_connections_test_load_test_http_method}
    # Start the test in the MiniAPI
    ${mini_api_server_test_started}=  Start Server Mini API    %{e2e_driveu_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_server_test_started}

    # After starting the DriveU server, we must start the DriveU client (Streamer)
    ${mini_api_client_test_started}=  Start Client Mini API    %{e2e_driveu_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke}    %{e2e_driveu_latency_and_throughput_test_server_ip}  %{e2e_driveu_latency_and_throughput_test_duration_seconds}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_client_test_started}

    # Try to get the results
    ${throughput_mbps}    ${mean_rtt_ms}=  Get Results And Evaluate Them    %{e2e_driveu_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke}
    # Log the results
    Log    Throughput (Mbps): ${throughput_mbps}
    Log    Mean RTT (ms): ${mean_rtt_ms}
    Run Keyword    Log to Console    Throughput (Mbps): ${throughput_mbps}
    Run Keyword    Log to Console    Mean RTT (ms): ${mean_rtt_ms}
    Log    Throughput Minimum Threshold (Mbps): %{e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold}
    Log    RTT Maximum Threshold RTT (ms): %{e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold}
    Log    Test duration (seconds): %{e2e_driveu_latency_and_throughput_test_duration_seconds}
    Run Keyword    Log to Console    Throughput Minimum Threshold (Mbps): %{e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold}
    Run Keyword    Log to Console    RTT Maximum Threshold RTT (ms): %{e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold}
    Run Keyword    Log to Console    Test duration (seconds): %{e2e_driveu_latency_and_throughput_test_duration_seconds}

    # After getting the results we may stop the DriveU server that was started
    ${mini_api_server_test_stopped}=  Stop Server Mini API    %{e2e_driveu_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_server_test_stopped}


    # Now, we have to evaluate the results agains the defined thresholds
    IF    ${throughput_mbps} >= %{e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold} and ${mean_rtt_ms} <= %{e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold} 
        Pass Execution    \n\nThe Target Network Application COMPLIES with the minimum threshold set for the throughput (%{e2e_driveu_latency_and_throughput_test_min_bandwidth_mbps_threshold} Mbps) and with the maximum threshold set for the RTT value (%{e2e_driveu_latency_and_throughput_test_max_rtt_ms_threshold} ms).\n
    ELSE
        Fail  \n\nThe Target Network Application DOES NOT comply with the minimum threshold set for the throughput or with the maximum threshold for RTT.\n
    END
