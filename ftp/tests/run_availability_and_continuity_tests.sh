#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2024-02-03 18:40:52
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2024-02-03 22:09:19
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

reporting_api_ip=10.255.28.173
reporting_api_port=3000

nef_url=http://10.255.28.173:8888

# 3. Run the tests

######################################################
#                                                    #
#             nef_authentication_test                #
#                                                    #
######################################################

export nef_authentication_test_reporting_api_ip=$reporting_api_ip
export nef_authentication_test_reporting_api_port=$reporting_api_port
export nef_authentication_test_mini_api_endpoint_to_invoke=http://$mini_api_endpoint_to_invoke_server/start/Def19Sec9
#run_test "nef_authentication_test"


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
