#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2024-02-03 18:30:41
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-02-05 09:15:45

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
    else
        echo "ALL TESTS PASSED!"
    fi
}

# 1. Start by creating a venv
create_venv

# 2. Define some global variables

# - Mini APIs
mini_api_ue_url=http://localhost:31391/miniapi  # Network Application
mini_api_server_url=http://localhost:3001       # NetworkAppControl-MiniAPI
mini_api_ip_server=192.168.247.2
# - NEF
nef_ip=192.168.237.6
nef_port=80


# 3. Run the tests

######################################################
#                                                    #
#          mini_api_configuration (Server)           #
#                                                    #
######################################################
export mini_api_configuration_configuration_endpoint="$mini_api_server_url/configure"
export mini_api_configuration_configuration_payload="{\"variables\":{\"NEF_IP\":\"$nef_ip\",\"NEF_PORT\":$nef_port,\"NEF_LOGIN_USERNAME\":\"admin@my-email.com\",\"NEF_LOGIN_PASSWORD\":\"pass\",\"SUBS_MONITORING_TYPE\":\"LOCATION_REPORTING\", \"SUBS_EXTERNAL_ID\": \"10001@domain.com\", \"SUBS_CALLBACK_URL\":\"$mini_api_server_url/monitoring/callback\",\"SUBS_MONITORING_EXPIRE_TIME\":\"2024-03-09T13:18:19.495000+00:00\",\"UE1_NAME\":\"My UE\",\"UE1_DESCRIPTION\":\"My UE Description\",\"UE1_IPV4\":\"10.10.10.10\",\"UE1_IPV6\":\"0:0:0:0:0:0:0:0\",\"UE1_MAC_ADDRESS\":\"22-00-00-00-00-02\",\"UE1_SUPI\":\"202010000000001\"}}"
# mini_api_configuration_configuration_payload - Must be updated (e.g. nef's ip and port, at least)
run_test "mini_api_configuration"


######################################################
#                                                    #
#           mini_api_configuration (UE)              #
#                                                    #
######################################################
export mini_api_configuration_configuration_endpoint="$mini_api_ue_url/configure"
export mini_api_configuration_configuration_payload="{\"variables\":{\"NEF_IP\":\"$nef_ip\",\"NEF_PORT\":$nef_port,\"NEF_LOGIN_USERNAME\":\"admin@my-email.com\",\"NEF_LOGIN_PASSWORD\":\"pass\",\"SUBS_MONITORING_TYPE\":\"LOCATION_REPORTING\", \"SUBS_EXTERNAL_ID\": \"10001@domain.com\", \"SUBS_CALLBACK_URL\":\"$mini_api_ue_url/monitoring/callback\",\"SUBS_MONITORING_EXPIRE_TIME\":\"2024-03-09T13:18:19.495000+00:00\",\"UE1_NAME\":\"My UE\",\"UE1_DESCRIPTION\":\"My UE Description\",\"UE1_IPV4\":\"10.10.10.10\",\"UE1_IPV6\":\"0:0:0:0:0:0:0:0\",\"UE1_MAC_ADDRESS\":\"22-00-00-00-00-02\",\"UE1_SUPI\":\"202010000000001\"}}"
# mini_api_configuration_configuration_payload - Must be updated (e.g. nef's ip and port, at least)
run_test "mini_api_configuration"


############################################################
#                                                          #
#  e2e_single_ue_latency_and_throughput_test (Def14Perf1)  #
#                                                          #
############################################################
# OS-Level Requirements
# For this test to run, `iperf3` must be installed on the VNF.
export e2e_single_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke="$mini_api_server_url/start/Def14Perf1"
export e2e_single_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke="$mini_api_server_url/stop/Def14Perf1"
export e2e_single_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke="$mini_api_ue_url/start/Def14Perf1"
export e2e_single_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke="$mini_api_ue_url/results/Def14Perf1"
export e2e_single_ue_latency_and_throughput_test_iperf_server_ip=$mini_api_ip_server # iperf server ip should point to the MiniAPI Server VNF
export e2e_single_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_single_ue_latency_and_throughput_test_max_rtt_ms_threshold=20
run_test "e2e_single_ue_latency_and_throughput_test"


##############################################################
#                                                            #
#  e2e_multiple_ue_latency_and_throughput_test (Def14Perf2)  #
#                                                            #
##############################################################
# OS-Level Requirements
# For this test to run, `iperf3` must be installed on the VNF.
export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_start_endpoint_to_invoke="$mini_api_server_url/start/Def14Perf2"
export e2e_multiple_ue_latency_and_throughput_test_server_mini_api_stop_endpoint_to_invoke="$mini_api_server_url/stop/Def14Perf2"
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_start_endpoint_to_invoke="$mini_api_ue_url/start/Def14Perf2"
export e2e_multiple_ue_latency_and_throughput_test_client_mini_api_results_endpoint_to_invoke="$mini_api_ue_url/results/Def14Perf2"
export e2e_multiple_ue_latency_and_throughput_test_iperf_server_ip=$mini_api_ip_server # iperf server ip should point to the MiniAPI Server VNF
export e2e_multiple_ue_latency_and_throughput_test_ue_count=50
export e2e_multiple_ue_latency_and_throughput_test_min_bandwidth_mbps_threshold=100
export e2e_multiple_ue_latency_and_throughput_test_max_rtt_ms_threshold=10
run_test "e2e_multiple_ue_latency_and_throughput_test"


###############################################################
#                                                             #
#  nef_signaling_performance_response_time_test (Def14Perf5)  #
#                                                             #
###############################################################
export nef_signaling_performance_response_time_test_host=$mini_api_ue_url
# nef_signaling_performance_response_time_test_host - Should be replaced with the host of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_response_time_test_endpoint=/monitoring/callback
# nef_signaling_performance_response_time_test_endpoint - Should be replaced with the endpoint of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_response_time_test_max_response_time_threshold_secs=5
run_test "nef_signaling_performance_response_time_test"


#####################################################################
#                                                                   #
#  nef_signaling_performance_requests_per_second_test (Def14Perf6)  #
#                                                                   #
#####################################################################
export nef_signaling_performance_requests_per_second_test_host=$mini_api_ue_url
# nef_signaling_performance_requests_per_second_test_host - Should be replaced with the host of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_requests_per_second_test_endpoint=/monitoring/callback
# nef_signaling_performance_requests_per_second_test_endpoint - Should be replaced with the endpoint of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_requests_per_second_test_min_threshold=5
run_test "nef_signaling_performance_requests_per_second_test"


#####################################################################
#                                                                   #
#  nef_signaling_performance_maximum_connections_test (Def14Perf7)  #
#                                                                   #
#####################################################################
# OS-Level Requirements
# For this test to run, either `netstat` or `ss` must be installed on the VNF that comprises the API that was declared for the NEF Callback.
export nef_signaling_performance_maximum_connections_test_load_test_host=$mini_api_ue_url
# nef_signaling_performance_maximum_connections_test_load_test_host - Should be replaced with the host of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_maximum_connections_test_load_test_endpoint=/
# nef_signaling_performance_maximum_connections_test_load_test_endpoint - Should be replaced with the endpoint of the Network Application's API that will deal with the NEF Callbacks
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke="$mini_api_ue_url/start/Def14Perf7"
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_cleanup="$mini_api_ue_url/stop/Def14Perf7"
export nef_signaling_performance_maximum_connections_test_mini_api_endpoint_to_invoke_results="$mini_api_ue_url/results/Def14Perf7"
export nef_signaling_performance_maximum_connections_test_connections_minimum_threshold=2
run_test "nef_signaling_performance_maximum_connections_test"


##############################################
#                                            #
#  web_performance_static_page (Def14Perf8)  #
#                                            #
##############################################
export web_performance_static_page_target=$mini_api_ue_url
# web_performance_static_page_target - Should be replaced with the URL of one of the static pages offered by Network Application
export web_performance_static_page_web_speed_net_threshold_bps=1000000 #1 MBs per second
run_test "web_performance_static_page"


################################################
#                                              #
#  api_performance_response_time (Def14Perf9)  #
#                                              #
################################################
export api_performance_response_time_api_target=$mini_api_ue_url
# api_performance_response_time_api_target - Should be replaced with the URL of one of the APIs offered by Network Application
export api_performance_response_time_threshold_ms=1000
run_test "api_performance_response_time"


#######################################################
#                                                     #
#  api_performance_requests_per_second (Def14Perf10)  #
#                                                     #
#######################################################
export api_performance_requests_per_second_host=$mini_api_ue_url
# api_performance_requests_per_second_host - Should be replaced with the host of one of the APIs offered by Network Application
export api_performance_requests_per_second_endpoint=/
# api_performance_requests_per_second_endpoint - Should be replaced with the endpoint of one of the APIs offered by Network Application
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=10
run_test "api_performance_requests_per_second"


######################################################
#                                                    #
#  maximum_number_of_connections_test (Def14Perf11)  #
#                                                    #
######################################################
# OS-Level Requirements
# For this test to run, either `netstat` or `ss` must be installed on the VNF that comprises the API that was declared for the NEF Callback.
export maximum_number_of_connections_test_load_test_host=$mini_api_ue_url
# maximum_number_of_connections_test_load_test_host - Should be replaced with the host of one of the APIs offered by Network Application
export maximum_number_of_connections_test_load_test_endpoint=/
# maximum_number_of_connections_test_load_test_endpoint - Should be replaced with the endpoint of one of the APIs offered by Network Application
export maximum_number_of_connections_test_load_test_http_method=GET
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke="$mini_api_ue_url/start/Def14Perf11"
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_cleanup="$mini_api_ue_url/stop/Def14Perf11"
export maximum_number_of_connections_test_mini_api_endpoint_to_invoke_results="$mini_api_ue_url/results/Def14Perf11"
export maximum_number_of_connections_test_connections_minimum_threshold=10
run_test "maximum_number_of_connections_test"


#######################################################
#                                                     #
#  network_application_performance_rtt (Def14Perf12)  #
#                                                     #
#######################################################
export network_application_performance_rtt_target=localhost
# network_application_performance_rtt_target - Should be replaced with the url of one of the APIs offered by Network Application
export network_application_performance_rtt_threshold_ms=500 # 500 milliseconds
run_test "network_application_performance_rtt"


######################################################
#                                                    #
#        hops_until_target_test (Def14Perf13)        #
#                                                    #
######################################################
# OS-Level Requirements
# For this test to run, `ping` must be installed on the VNF.
export hops_until_target_test_target=127.0.0.1
# network_application_performance_rtt_target - Should be replaced with a meaningful value - ideally the ip of one of the other VNFs
export hops_until_target_test_max_hops_threshold=20
export hops_until_target_test_mini_api_endpoint_to_invoke="$mini_api_ue_url/start/Def14Perf13"
export hops_until_target_test_mini_api_endpoint_to_invoke_results="$mini_api_ue_url/results/Def14Perf13"
run_test "hops_until_target_test"


# 4. Finally, print the tests that failed
print_failed_tests
