*** Settings ***
Library    Process
Library    nef_signaling_performance_requests_per_second_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Test Host: %{nef_signaling_performance_requests_per_second_test_host}
    Log    Test endpoint: %{nef_signaling_performance_requests_per_second_test_endpoint}
    Log    Minimum Threshhold - Requests Per Second: %{nef_signaling_performance_requests_per_second_test_min_threshold} requests/sec.
    Run Keyword    Log To Console    \n\nTest Host: %{nef_signaling_performance_requests_per_second_test_host}
    Run Keyword    Log To Console    \nTest endpoint: %{nef_signaling_performance_requests_per_second_test_endpoint}
    Run Keyword    Log To Console    \nMinimum Threshhold - Requests Per Second: %{nef_signaling_performance_requests_per_second_test_min_threshold} requests/sec.
    # This Locust Process will spwan 20 users at once and will try to make
    # requests to the target during 10 seconds.
    # The locust test result is a JSON that will be processed by a python
    # library to evaluate if the target api/server complies with the desired
    # number of requests served per seconds.  
    ${output}=    Run Process   locust    -f    locust_performance_test.py    --headless    -u    25    -r    25    --run-time    10    --host    %{nef_signaling_performance_requests_per_second_test_host}    --endpoint    %{nef_signaling_performance_requests_per_second_test_endpoint}    --json
    #Log    ${output.stdout} # This can be used for debugging
    ${median_requests_per_second}=    Evaluate Locust Results    ${output.stdout}
    # Log the result
    Log    Median Requests Per Second: ${median_requests_per_second} requests/sec.
    Run Keyword    Log To Console    \n\n[RESULT] Median Requests Per Second: ${median_requests_per_second} requests/sec.\n
    
    # Now, we have to evaluate the results agains the minimum threshold for
    # the number of requests per second
    IF    ${median_requests_per_second} >= %{nef_signaling_performance_requests_per_second_test_min_threshold}
        Pass Execution    \n\nThe Target Server/API COMPLIES with the minimum threshold set for number of requests/sec (%{nef_signaling_performance_requests_per_second_test_min_threshold}).\n
    ELSE
        Fail  \n\nThe Target Server/API DOES NOT comply with the minimum threshold set for number of requests/sec (%{nef_signaling_performance_requests_per_second_test_min_threshold}).\n
    END
