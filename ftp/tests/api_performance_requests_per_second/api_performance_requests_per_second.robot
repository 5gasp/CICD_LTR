*** Settings ***
Library    Process
Library    api_performance_requests_per_second.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Test Host: %{api_performance_requests_per_second_host}
    Log    Test endpoint: %{api_performance_requests_per_second_endpoint}
    Log    Test HTTP Method: %{api_performance_requests_per_second_http_method}
    Log    Minimum Threshhold - Requests Per Second: %{api_performance_requests_per_second_min_threshold} requests/sec.
    Run Keyword    Log To Console    \n\nTest Host: %{api_performance_requests_per_second_host}
    Run Keyword    Log To Console    \nTest endpoint: %{api_performance_requests_per_second_endpoint}
    Run Keyword    Log To Console    \nTest HTTP Method: %{api_performance_requests_per_second_http_method}
    Run Keyword    Log To Console    \nMinimum Threshhold - Requests Per Second: %{api_performance_requests_per_second_min_threshold} requests/sec.
    # This Locust Process will spwan 50 users at once and will try to make
    # requests to the target during 10 seconds.
    # The locust test result is a JSON that will be processed by a python
    # library to evaluate if the target api/server complies with the desired
    # number of requests served per seconds.  
    ${output}=    Run Process   locust    -f    locust_performance_test.py    --headless    -u    50    -r    50    --run-time    10    --host    %{api_performance_requests_per_second_host}    --endpoint    %{api_performance_requests_per_second_endpoint}    --http-method    %{api_performance_requests_per_second_http_method}    --json
    #Log    ${output.stdout} # This can be used for debugging
    ${median_requests_per_second}=    Evaluate Locust Results    ${output.stdout}
    # Log the result
    Log    Median Requests Per Second: ${median_requests_per_second} requests/sec.
    Run Keyword    Log To Console    \n\n[RESULT] Median Requests Per Second: ${median_requests_per_second} requests/sec.\n
    
    # Now, we have to evaluate the results agains the minimum threshold for
    # the number of requests per second
    IF    ${median_requests_per_second} >= %{api_performance_requests_per_second_min_threshold}
        Pass Execution    \n\nThe Target Server/API COMPLIES with the minimum threshold set for number of requests/sec (%{api_performance_requests_per_second_min_threshold}).\n
    ELSE
        Fail  \n\nThe Target Server/API DOES NOT comply with the minimum threshold set for number of requests/sec (%{api_performance_requests_per_second_min_threshold}).\n
    END
