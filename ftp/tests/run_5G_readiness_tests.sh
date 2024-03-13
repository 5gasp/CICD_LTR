#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2024-02-03 18:23:29
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-02-04 12:21:41

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
mini_api_server_url=http://10.255.28.201:3001
mini_api_ue_url=http://10.255.28.192:3001
# - Reporting API
reporting_api_ip=10.255.28.236
reporting_api_port=3000


# 3. Run the tests

######################################################
#                                                    #
#          mini_api_configuration (Server)           #
#                                                    #
######################################################
export mini_api_configuration_configuration_endpoint="$mini_api_server_url/configure"
export mini_api_configuration_configuration_payload='{"variables":{"NEF_IP":"10.255.28.236","NEF_PORT":8888,"NEF_LOGIN_USERNAME":"admin@my-email.com","NEF_LOGIN_PASSWORD":"pass","SUBS_MONITORING_TYPE":"LOCATION_REPORTING", "SUBS_EXTERNAL_ID": "10001@domain.com", "SUBS_CALLBACK_URL":"https://webhook.site/43d72330-0f8e-4a52-af1c-65c77d9aafd0","SUBS_MONITORING_EXPIRE_TIME":"2024-03-09T13:18:19.495000+00:00","UE1_NAME":"My UE","UE1_DESCRIPTION":"My UE Description","UE1_IPV4":"10.10.10.10","UE1_IPV6":"0:0:0:0:0:0:0:0","UE1_MAC_ADDRESS":"22-00-00-00-00-02","UE1_SUPI":"202010000000001"}}'
# mini_api_configuration_configuration_payload - Must be updated (e.g. nef's ip and port, at least)
run_test "mini_api_configuration"


######################################################
#                                                    #
#           mini_api_configuration (UE)              #
#                                                    #
######################################################
export mini_api_configuration_configuration_endpoint="$mini_api_ue_url/configure"
export mini_api_configuration_configuration_payload='{"variables":{"NEF_IP":"10.255.28.236","NEF_PORT":8888,"NEF_LOGIN_USERNAME":"admin@my-email.com","NEF_LOGIN_PASSWORD":"pass","SUBS_MONITORING_TYPE":"LOCATION_REPORTING", "SUBS_EXTERNAL_ID": "10001@domain.com", "SUBS_CALLBACK_URL":"https://webhook.site/43d72330-0f8e-4a52-af1c-65c77d9aafd0","SUBS_MONITORING_EXPIRE_TIME":"2024-03-09T13:18:19.495000+00:00","UE1_NAME":"My UE","UE1_DESCRIPTION":"My UE Description","UE1_IPV4":"10.10.10.10","UE1_IPV6":"0:0:0:0:0:0:0:0","UE1_MAC_ADDRESS":"22-00-00-00-00-02","UE1_SUPI":"202010000000001"}}'
# mini_api_configuration_configuration_payload - Must be updated (e.g. nef's ip and port, at least)
run_test "mini_api_configuration"


######################################################
#                                                    #
#             nef_authentication_test                #
#                                                    #
######################################################
export nef_authentication_test_reporting_api_ip=$reporting_api_ip
export nef_authentication_test_reporting_api_port=$reporting_api_port
export nef_authentication_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def19Sec9"
run_test "nef_authentication_test"


######################################################
#                                                    #
#            authentication_with_5gs_test            #
#                                                    #
######################################################
export authentication_with_5gs_test_reporting_api_ip=$reporting_api_ip
export authentication_with_5gs_test_reporting_api_port=$reporting_api_port
export authentication_with_5gs_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G1"
run_test "authentication_with_5gs_test"


######################################################
#                                                    #
#          nef_monitoring_subscription_test          #
#                                                    #
######################################################
export nef_monitoring_subscription_test_reporting_api_ip=$reporting_api_ip
export nef_monitoring_subscription_test_reporting_api_port=$reporting_api_port
export nef_monitoring_subscription_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G2"
run_test "nef_monitoring_subscription_test"


######################################################
#                                                    #
#                nef_handover_test                   #
#                                                    #
######################################################
export nef_ue_handover_test_reporting_api_ip=$reporting_api_ip
export nef_ue_handover_test_reporting_api_port=$reporting_api_port
export nef_ue_handover_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G3"
export nef_ue_handover_test_ue_supi=202010000000001
run_test "nef_handover_test"


######################################################
#                                                    #
#           nef_ue_rsrp_acquisition_test             #
#                                                    #
######################################################
export nef_ue_rsrp_acquisition_test_reporting_api_ip=$reporting_api_ip
export nef_ue_rsrp_acquisition_test_reporting_api_port=$reporting_api_port
export nef_ue_rsrp_acquisition_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G4"
export nef_ue_rsrp_acquisition_test_ue_supi=202010000000001
run_test "nef_ue_rsrp_acquisition_test"


######################################################
#                                                    #
#              nef_ue_path_loss_test                 #
#                                                    #
######################################################
export nef_ue_path_loss_test_reporting_api_ip=$reporting_api_ip
export nef_ue_path_loss_test_reporting_api_port=$reporting_api_port
export nef_ue_path_loss_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G5"
export nef_ue_path_loss_test_ue_supi=202010000000001
run_test "nef_ue_path_loss_test"


######################################################
#                                                    #
#             nef_serving_cell_info_test             #
#                                                    #
######################################################
export nef_serving_cell_info_test_reporting_api_ip=$reporting_api_ip
export nef_serving_cell_info_test_reporting_api_port=$reporting_api_port
export nef_serving_cell_info_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G6"
export nef_serving_cell_info_test_ue_supi=202010000000001
run_test "nef_serving_cell_info_test"


######################################################
#                                                    #
#             nef_qos_subscription_test              #
#                                                    #
######################################################
export nef_qos_subscription_test_reporting_api_ip=$reporting_api_ip
export nef_qos_subscription_test_reporting_api_port=$reporting_api_port
export nef_qos_subscription_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def115G7"
export nef_qos_subscription_test_monitoring_payload='{"ipv4Addr":"10.0.0.1","notificationDestination":"http://127.0.0.1/callback","snssai":{"sst":1,"sd":"000001"},"dnn":"province1.mnc01.mcc202.gprs","qosReference":9,"altQoSReferences":[0],"usageThreshold":{"duration":0,"totalVolume":0,"downlinkVolume":0,"uplinkVolume":0},"qosMonInfo":{"reqQosMonParams":["DOWNLINK"],"repFreqs":["EVENT_TRIGGERED"],"latThreshDl":0,"latThreshUl":0,"latThreshRp":0,"waitTime":0,"repPeriod":0}}'
run_test "nef_qos_subscription_test"


# 4. Finally, print the tests that failed
print_failed_tests
