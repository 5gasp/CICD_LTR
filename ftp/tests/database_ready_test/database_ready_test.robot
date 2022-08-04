*** Settings ***
Library        database_ready_test.py

*** Test Cases ***
Checking if %{database_ready_test_entity_name}'s databases is ready

    ${output}=    Check Database    %{database_ready_test_entity_name}  %{database_ready_test_host}  %{database_ready_test_port}
    Should Be Equal    ${output}    Success: The entity database is ready