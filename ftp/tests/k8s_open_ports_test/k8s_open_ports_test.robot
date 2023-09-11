*** Settings ***
Library        k8s_open_ports_test.py
Test Timeout  15 minutes

*** Test Cases ***
Testing the open ports of a CNF
    ${k8s_open_ports_test_status}=    Test K8S Open Ports    %{k8s_open_ports_test_deployment_info_file_path=NONE}  %{k8s_open_ports_test_expected_open_ports}

    IF  '${k8s_open_ports_test_status[0]}' == '0'
        Pass Execution  \nSuccess: ${k8s_open_ports_test_status[1]}
    ELSE IF  '${k8s_open_ports_test_status[0]}' in ['1', '2', '3', '4']
        Fail  \n${k8s_open_ports_test_status[1]}
    ELSE
        Fail  \nUnknown Error
    END