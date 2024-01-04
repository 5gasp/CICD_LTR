*** Settings ***
Library    Process
Library    nef_signaling_performance_response_time_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Test Host: %{nef_signaling_performance_response_time_test_host}
    Log    Test endpoint: %{nef_signaling_performance_response_time_test_endpoint}
    Log    Maximum Threshhold - Response Time: %{nef_signaling_performance_response_time_test_max_response_time_threshold_secs} secs.
    Run Keyword    Log To Console    \n\nTest Host: %{nef_signaling_performance_response_time_test_host}
    Run Keyword    Log To Console    \nTest endpoint: %{nef_signaling_performance_response_time_test_endpoint}
    Run Keyword    Log To Console    \nMaximum Threshhold - Response Time: %{nef_signaling_performance_response_time_test_max_response_time_threshold_secs} secs.
    # This Locust Process will spwan 25 users at once and will try to make
    # requests to the target during 10 seconds.
    # The locust test result is a JSON that will be processed by a python
    # library to evaluate if the target api/server complies with the desired
    # number of requests served per seconds.  
    ${output}=    Run Process   locust    -f    locust_performance_test.py    --headless    -u    25    -r    25    --run-time    10    --host    %{nef_signaling_performance_response_time_test_host}    --endpoint    %{nef_signaling_performance_response_time_test_endpoint}    --json
    Log    ${output.stdout}
    
    ${avg_response_time}=    Evaluate Locust Results    ${output.stdout}
    # Log the result
    Log    Average Response Time: ${avg_response_time} sec.
    Run Keyword    Log To Console    \n\n[RESULT] Average Response Time: ${avg_response_time} sec.\n

    # Now, we have to evaluate the results agains the minimum threshold for
    # the number of requests per second
    IF    ${avg_response_time} <= %{nef_signaling_performance_response_time_test_max_response_time_threshold_secs}
        Pass Execution    \n\nThe Target Server/API COMPLIES with the maximum threshold set for the response time (%{nef_signaling_performance_response_time_test_max_response_time_threshold_secs} secs).\n
    ELSE
        Fail  \n\nThe Target Server/API DOES NOT comply with the maximum threshold set for the response time (%{nef_signaling_performance_response_time_test_max_response_time_threshold_secs} secs).\n
    END
