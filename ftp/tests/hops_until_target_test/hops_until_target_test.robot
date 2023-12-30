*** Settings ***
Library    Process
Library    hops_until_target_test.py


*** Test Cases ***
Run Locust Requests Per Second Test
    # Log Initial Input
    Log    Test Target: %{hops_until_target_test_target}.
    Log    Maximum Threshhold - Hops Until Target: %{hops_until_target_test_max_hops_threshold} hops.
    Run Keyword    Log To Console    \n\nTest Target: %{hops_until_target_test_target}
    Run Keyword    Log To Console    \nMaximum Threshhold - Hops Until Target: %{hops_until_target_test_max_hops_threshold} hops.
    # Start the test in the MiniAPI Test
    ${mini_api_test_started}=  Start Mini Api Test    %{hops_until_target_test_mini_api_endpoint_to_invoke}    %{hops_until_target_test_target}
    # Check if the test was started in the MiniAPI
    Should Be True  ${mini_api_test_started}
    # Try to get the results from the MiniAPI
    ${hops_until_target}=  Get Results And Evaluate Them    %{hops_until_target_test_mini_api_endpoint_to_invoke_results}    %{hops_until_target_test_target}
    # Log the output
    Log    Hops Until Target: ${hops_until_target}.
    Run Keyword    Log To Console    \n\nHops Until Target: ${hops_until_target}.
    # Compute the test outcome
    IF    ${hops_until_target} > 0 and ${hops_until_target} <= %{hops_until_target_test_max_hops_threshold}
        Pass Execution    \n\nThe Network Application was ABLE to reach the target with less than %{hops_until_target_test_max_hops_threshold} hops.\n
    ELSE
        Fail  \n\nThe Network Application was UNABLE to reach the target with less than %{hops_until_target_test_max_hops_threshold} hops.\n
    END