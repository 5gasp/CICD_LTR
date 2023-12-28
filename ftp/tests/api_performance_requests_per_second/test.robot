*** Settings ***
Library    Process
Library    evaluate.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # This Locust Process will spwan 50 users at once and will try to make
    # requests to the target during 10 seconds.
    # The locust test result is a JSON that will be processed by a python
    # library to evaluate if the target api/server complies with the desired
    # number of requests served per seconds.  
    ${output}=    Run Process   locust    -f    test.py    --headless    -u    50    -r    50    --run-time    5    --host    https://atnog-harbor.av.it.pt    --endpoint    /    --json
    #Log    ${output.stdout} # This can be used for debugging
    ${median_requests_per_second}=    Evaluate Locust Results    ${output.stdout}
    # Now, we have to evaluate the results agains the minimum threshold for
    # the number of requests per second
    IF    ${median_requests_per_second} >= %{api_performance_requests_per_second_min_threshold}
        Pass Execution    \nThe Target Server/API COMPLIES with the minimum threshold set for number of requests/sec (%{api_performance_requests_per_second_min_threshold}).
    ELSE
        Fail  \nThe Target Server/API DOES NOT comply with the minimum threshold set for number of requests/sec (%{api_performance_requests_per_second_min_threshold}).
    END