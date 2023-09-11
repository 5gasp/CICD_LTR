export k8s_open_ports_test_deployment_info_file_path="./deployment-info.json"
export k8s_open_ports_test_expected_open_ports=30101
python3 -m robot .
