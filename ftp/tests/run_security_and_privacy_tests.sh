#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2024-02-03 18:34:45
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-02-04 12:40:36

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
mini_api_ip_server=10.255.28.201

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
export mini_api_configuration_configuration_payload='{"variables":{"NEF_IP":"10.255.28.236","NEF_PORT":8888,"NEF_LOGIN_USERNAME":"admin@my-email.com","NEF_LOGIN_PASSWORD":"pass","SUBS_MONITORING_TYPE":"LOCATION_REPORTING", "SUBS_EXTERNAL_ID": "123456789@domain.com", "SUBS_CALLBACK_URL":"https://webhook.site/43d72330-0f8e-4a52-af1c-65c77d9aafd0","SUBS_MONITORING_EXPIRE_TIME":"2024-03-09T13:18:19.495000+00:00","UE1_NAME":"My UE","UE1_DESCRIPTION":"My UE Description","UE1_IPV4":"10.10.10.10","UE1_IPV6":"0:0:0:0:0:0:0:0","UE1_MAC_ADDRESS":"22-00-00-00-00-02","UE1_SUPI":"202010000000001"}}'
# mini_api_configuration_configuration_payload - Must be updated (e.g. nef's ip and port, at least)
run_test "mini_api_configuration"


######################################################
#                                                    #
#                    ssl_audit                       #
#                                                    #
######################################################
export ssl_audit_url=5gasp.eu
# ssl_audit_url - Should be replaced with the URL of one of the APIs/Web Pages offered by Network Application
run_test "ssl_audit"


######################################################
#                                                    #
#                 ssh_brute_force                    #
#                                                    #
######################################################
export usernames_list_file_path=example_artifacts/top-usernames-shortlist.txt
export passwords_list_file_path=example_artifacts/1000-most-common-passwords.txt
export ssh_brute_force_max_password_to_test=10
export ssh_brute_force_max_usernames_to_test=5
export ssh_brute_force_target_ip=$mini_api_ip_server
run_test "ssh_brute_force"


######################################################
#                                                    #
#                    open_ports                      #
#                                                    #
######################################################
# OS-Level Requirements
# For this test to run, `nmap` must be installed on the CI/CD Agent.
export open_ports_host=$mini_api_ip_server
export open_ports_expected_open_ports="22/tcp,3001/tcp"
run_test "open_ports"


######################################################
#                                                    #
#                    ssh_audit                       #
#                                                    #
######################################################
export ssh_audit_ssh_host=$mini_api_ip_server
export ssh_audit_ssh_port=22
run_test "ssh_audit"


######################################################
#                                                    #
#             nef_authentication_test                #
#                                                    #
######################################################
export nef_authentication_test_reporting_api_ip=$reporting_api_ip
export nef_authentication_test_reporting_api_port=$reporting_api_port
export nef_authentication_test_mini_api_endpoint_to_invoke="$mini_api_server_url/start/Def19Sec9"
run_test "nef_authentication_test"


# 4. Finally, print the tests that failed
print_failed_tests
