#!/bin/bash
# @Author: Rafael Direito
# @Date:   2024-01-31 16:33:39
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2024-02-02 12:05:12

# Save the current working directory
root_directory="$(pwd)"
# Initialize an empty list to store failed tests
failed_tests=()

create_venv() {
    local venv_name="venv"

    # Check if the venv directory already exists
    if [ -d "$venv_name" ]; then
        echo "Virtual environment '$venv_name' already exists. We will update pip."
        source venv/bin/activate
        pip install --upgrade pip
    else
        echo "Creating virtual environment '$venv_name'..."
        python3 -m venv "$venv_name"
        source venv/bin/activate
        pip install --upgrade pip

        if [ $? -eq 0 ]; then
            echo "Virtual environment '$venv_name' created successfully."
        else
            echo "Error: Failed to create virtual environment."
        fi
    fi
}


run_test() {
    local test_folder="$1"
    local results_folder="results/${test_folder}_results"

    # Check if the results folder exists
    if [ -d "$results_folder" ]; then
        # If it exists, clean it by removing its contents
        echo "Cleaning existing results folder: $results_folder"
        rm -rf "$results_folder"/*
    else
        # If it doesn't exist, create it
        echo "Creating results folder: $results_folder"
        mkdir -p "$results_folder"
    fi

    # Enter venv and install test dependencies
    source venv/bin/activate
    pip install -r "$test_folder"/requirements.txt

    # Finally, perform the test
    cd "$test_folder"
    python3 -m robot --outputdir "../$results_folder" .

    # If the test failed, save its name for later
    status_code=$?

    if [ "$status_code" -ne 0 ]; then
        echo "Robot Framework test encountered an error. Status code: $status_code"
        failed_tests+=("$test_folder")
    fi

    cd "$root_directory"
}

print_failed_tests(){
    # Print the list of failed test folders (if any)
    if [ "${#failed_tests[@]}" -gt 0 ]; then
        echo -e "\n\n[TESTS THAT FAILED]:"
        for folder in "${failed_tests[@]}"; do
            echo "  - $folder"
        done
    fi
}

# 1. Start by creating a venv
create_venv

# 2. Define some global variables
mini_api_ip_server=10.255.28.233
mini_api_port_server=8000
mini_api_endpoint_to_invoke_server=10.255.28.233:8000

mini_api_ip_ue=10.255.28.210
mini_api_port_ue=8000
mini_api_endpoint_to_invoke_ue=10.255.28.210:8000

reporting_api_ip=10.255.28.173
reporting_api_port=3000

nef_url=http://10.255.28.173:8888

# 3. Run the tests

######################################################
#                                                    #
#            authentication_with_5gs_test            #
#                                                    #
######################################################

export authentication_with_5gs_test_reporting_api_ip=$reporting_api_ip
export authentication_with_5gs_test_reporting_api_port=$reporting_api_port
export authentication_with_5gs_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G1
#run_test "authentication_with_5gs_test"

######################################################
#                                                    #
#          api_performance_requests_per_second       #
#                                                    #
######################################################
export api_performance_requests_per_second_host=https://google.pt
export api_performance_requests_per_second_endpoint=/
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=10
#run_test "api_performance_requests_per_second"

######################################################
#                                                    #
#             api_performance_response_time          #
#                                                    #
######################################################
export api_performance_response_time_api_target=https://google.pt
export api_performance_response_time_threshold_ms=1000
#run_test "api_performance_response_time"

######################################################
#                                                    #
#          nef_monitoring_subscription_test          #
#                                                    #
######################################################

export nef_monitoring_subscription_test_reporting_api_ip=$reporting_api_ip
export nef_monitoring_subscription_test_reporting_api_port=$reporting_api_port
export nef_monitoring_subscription_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G2
#run_test "nef_monitoring_subscription_test"

######################################################
#                                                    #
#                nef_handover_test                   #
#                                                    #
######################################################

export nef_ue_handover_test_reporting_api_ip=$reporting_api_ip
export nef_ue_handover_test_reporting_api_port=$reporting_api_port
export nef_ue_handover_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G3
export nef_ue_handover_test_ue_supi=202010000000001
#run_test "nef_handover_test"

######################################################
#                                                    #
#           nef_ue_rsrp_acquisition_test             #
#                                                    #
######################################################

export nef_ue_rsrp_acquisition_test_reporting_api_ip=$reporting_api_ip
export nef_ue_rsrp_acquisition_test_reporting_api_port=$reporting_api_port
export nef_ue_rsrp_acquisition_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G4
export nef_ue_rsrp_acquisition_test_ue_supi=202010000000001
#run_test "nef_ue_rsrp_acquisition_test"

######################################################
#                                                    #
#              nef_ue_path_loss_test                 #
#                                                    #
######################################################

export nef_ue_path_loss_test_reporting_api_ip=$reporting_api_ip
export nef_ue_path_loss_test_reporting_api_port=$reporting_api_port
export nef_ue_path_loss_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G5
export nef_ue_path_loss_test_ue_supi=202010000000001
#run_test "nef_ue_path_loss_test"

######################################################
#                                                    #
#             nef_serving_cell_info_test             #
#                                                    #
######################################################

export nef_serving_cell_info_test_reporting_api_ip=$reporting_api_ip
export nef_serving_cell_info_test_reporting_api_port=$reporting_api_port
export nef_serving_cell_info_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G6
export nef_serving_cell_info_test_ue_supi=202010000000001
#run_test "nef_serving_cell_info_test"

######################################################
#                                                    #
#             nef_qos_subscription_test              #
#                                                    #
######################################################

export nef_qos_subscription_test_reporting_api_ip=$reporting_api_ip
export nef_qos_subscription_test_reporting_api_port=$reporting_api_port
export nef_qos_subscription_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def115G7
export nef_qos_subscription_test_monitoring_payload='{"ipv4Addr":"10.0.0.1","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}'
#run_test "nef_qos_subscription_test"

######################################################
#                                                    #
#              openstack_port_security               #
#                                                    #
######################################################

export openstack_port_security_deployment_info_file_path=NONE
#run_test "openstack_port_security"

######################################################
#                                                    #
#                    ssl_audit                       #
#                                                    #
######################################################

export ssl_audit_url=ci-cd-service.5gasp.eu
#run_test "ssl_audit"

######################################################
#                                                    #
#                 ssh_brute_force                    #
#                                                    #
######################################################

export usernames_list_file_path=example_artifacts/top-usernames-shortlist.txt
export passwords_list_file_path=example_artifacts/1000-most-common-passwords.txt
#run_test "ssh_brute_force"

######################################################
#                                                    #
#                    open_ports                      #
#                                                    #
######################################################

export open_ports_host=$mini_api_ip_server
export open_ports_expected_open_ports=22/tcp
#run_test "open_ports"

######################################################
#                                                    #
#                    ssh_audit                       #
#                                                    #
######################################################

export ssh_audit_ssh_host=$mini_api_ip_server
export ssh_audit_ssh_port=22
#run_test "ssh_audit"

######################################################
#                                                    #
#      e2e_single_ue_latency_and_throughput_test     #
#                                                    #
######################################################

# OS-Level Requirements
# Ubuntu 20.04 - for this test to run, `iperf3` must be installed on the VNF.

export e2e_single_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/stop/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_ue/start/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_ue/results/Def14Perf1
export e2e_single_ue_latency_and_throughput_test_iperf_server_ip=$mini_api_ip_server # iperf server ip should point to the MiniAPI Server VNF
export e2e_single_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_single_ue_latency_and_throughput_test_max_rtt_ms_threshold=20
#run_test "e2e_single_ue_latency_and_throughput_test"

######################################################
#                                                    #
#     e2e_multiple_ue_latency_and_throughput_test    #
#                                                    #
######################################################

# OS-Level Requirements
# Ubuntu 20.04 - for this test to run, `iperf3` must be installed on the VNF.

export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def14Perf1
export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/stop/Def14Perf1
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_ue/start/Def14Perf1
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_ue/results/Def14Perf1
export e2e_multiple_ue_latency_and_throughput_test_iperf_server_ip=$mini_api_ip_server # iperf server ip should point to the MiniAPI Server VNF
export e2e_multiple_ue_latency_and_throughput_test_ue_count=50
export e2e_multiple_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_multiple_ue_latency_and_throughput_test_max_rtt_ms_threshold=10
#run_test "e2e_multiple_ue_latency_and_throughput_test"

######################################################
#                                                    #
#    nef_signaling_performance_response_time_test    #
#                                                    #
######################################################

export nef_signaling_performance_response_time_test_host=https://webhook.site
export nef_signaling_performance_response_time_test_endpoint=/8c969d79-a392-41e4-9805-07c430cd0d41
export nef_signaling_performance_response_time_test_max_response_time_threshold_secs=2
#run_test "nef_signaling_performance_response_time_test"

######################################################
#                                                    #
# nef_signaling_performance_requests_per_second_test #
#                                                    #
######################################################

export nef_signaling_performance_requests_per_second_test_host=https://webhook.site
export nef_signaling_performance_requests_per_second_test_endpoint=/be0358ea-77d3-4496-9574-1203590b2b0c
export nef_signaling_performance_requests_per_second_test_min_threshold=5
#run_test "nef_signaling_performance_requests_per_second_test"

######################################################
#                                                    #
# nef_signaling_performance_maximum_connections_test #
#                                                    #
######################################################

# OS-Level Requirements
# Ubuntu 20.04 - for this test to run, either `netstat` or `ss` must be installed on the VNF that comprises the API that was declared for the NEF Callback.

export nef_signaling_performance_maximum_connections_test_load_test_host=http://$mini_api_ip_server:8080
export nef_signaling_performance_maximum_connections_test_load_test_endpoint=/
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def14Perf7
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup=http://$mini_api_endpoint_to_invoke_server/stop/Def14Perf7
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results=http://$mini_api_endpoint_to_invoke_server/results/Def14Perf7
export nef_signaling_performance_maximum_connections_test_connections_minimum_threshold=2
#run_test "nef_signaling_performance_maximum_connections_test"

######################################################
#                                                    #
#            web_performance_static_page             #
#                                                    #
######################################################

export web_performance_static_page_target=https://google.pt
export web_performance_static_page_web_speed_net_threshold_bps=5000000 #5 MBs per second
#run_test "web_performance_static_page"

######################################################
#                                                    #
#         maximum_number_of_connections_test         #
#                                                    #
######################################################

# OS-Level Requirements
# Ubuntu 20.04 - for this test to run, either `netstat` or `ss` must be installed on the VNF that comprises the API that was declared for the NEF Callback.

export maximum_number_of_connections_test_load_test_host=http://$mini_api_ip_server:8080
export maximum_number_of_connections_test_load_test_endpoint=/
export maximum_number_of_connections_test_load_test_http_method=GET
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def14Perf11
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_cleanup=http://$mini_api_endpoint_to_invoke_server/stop/Def14Perf11
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_results=http://$mini_api_endpoint_to_invoke_server/results/Def14Perf11
export maximum_number_of_connections_test_connections_minimum_threshold=10
#run_test "maximum_number_of_connections_test"

######################################################
#                                                    #
#        network_application_performance_rtt         #
#                                                    #
######################################################

export network_application_performance_rtt_target=5gasp.eu
export network_application_performance_rtt_threshold_ms=500 # 500 milliseconds
#run_test "network_application_performance_rtt"

######################################################
#                                                    #
#              hops_until_target_test                #
#                                                    #
######################################################

# OS-Level Requirements
# Ubuntu 20.04 - for this test to run, `ping` must be installed on the VNF.

export hops_until_target_test_target=8.8.8.8
export hops_until_target_test_max_hops_threshold=20
export hops_until_target_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def14Perf13
export hops_until_target_test_mini_api_endpoint_to_invoke_results=http://$mini_api_endpoint_to_invoke_server/results/Def14Perf13
#run_test "hops_until_target_test"

######################################################
#                                                    #
#       availability_and_continuity_bandwidth        #
#                                                    #
######################################################

export availability_and_continuity_bandwidth_NEFURL=$nef_url
#run_test "availability_and_continuity_bandwidth"

######################################################
#                                                    #
#        availability_and_continuity_latency         #
#                                                    #
######################################################

export availability_and_continuity_latency_NEFURL=$nef_url
#run_test "availability_and_continuity_latency"

######################################################
#                                                    #
#      availability_and_continuity_packet_loss       #
#                                                    #
######################################################

export availability_and_continuity_packet_loss_NEFURL=$nef_url
#run_test "availability_and_continuity_packet_loss"

######################################################
#                                                    #
#   availability_and_continuity_packet_corruption    #
#                                                    #
######################################################

export availability_and_continuity_packet_corruption_NEFURL=$nef_url
#run_test "availability_and_continuity_packet_corruption"

######################################################
#                                                    #
#   availability_and_continuity_communication_loss   #
#                                                    #
######################################################

export availability_and_continuity_communication_loss_NEFURL=$nef_url
#run_test "availability_and_continuity_communication_loss"

# 4. Finally, print the tests that failed
print_failed_tests