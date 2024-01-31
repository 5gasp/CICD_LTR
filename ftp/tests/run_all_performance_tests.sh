#!/bin/bash
# @Author: Rafael Direito
# @Date:   2024-01-31 16:33:39
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-31 17:11:02

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

    cd $root_directory
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
performace_test_api_target=https://google.pt
performace_test_api_endpoint=/
# Todo mini_api_ip_server=127.0.0.1
# Todo mini_api_ip_ue=127.0.0.1

# 3. Run the tests

######################################################
#                                                    #
#             api_performance_response_time          #
#                                                    #
######################################################
export api_performance_response_time_api_target=$performace_test_api_target
export api_performance_response_time_threshold_ms=1000
run_test "api_performance_response_time"


######################################################
#                                                    #
#          api_performance_requests_per_second       #
#                                                    #
######################################################
export api_performance_requests_per_second_host=$performace_test_api_target
export api_performance_requests_per_second_endpoint=$performace_test_api_endpoint
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=10
run_test "api_performance_requests_per_second"

# 4. Finally, print the tests that failed
print_failed_tests