#!/bin/bash
# @Author: Eduardo Santos
# @Date:   2024-02-03 18:55:02
# @Last Modified by:   Eduardo Santos
# @Last Modified time: 2024-02-03 21:59:02
#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]; then
    printf "\n"
    echo "Usage: $0 <test_category>"
    printf "\n"
    echo "Available Testing Axis:"
    echo "1 - 5G Readiness"                
    echo "2 - Performance & Scalability"   
    echo "3 - Security & Privacy"          
    echo "4 - Availability & Continuity"   
    exit 1
fi

test_category=$1

# Map the input argument to the corresponding test file
case $test_category in
    1)
        test_file="run_5G_readiness_tests.sh"
        ;;
    2)
        test_file="run_performance_and_scalability_tests.sh"
        ;;
    3)
        test_file="run_security_and_privacy_tests.sh"
        ;;
    4)
        test_file="run_availability_and_continuity_tests.sh"
        ;;
    *)
        printf "\n"
        echo "Invalid Testing Axis: $test_category"
        printf "\n"
        echo "Available Testing Axis:"
        echo "1 - 5G Readiness"                
        echo "2 - Performance & Scalability"   
        echo "3 - Security & Privacy"          
        echo "4 - Availability & Continuity" 
        exit 1
        ;;
esac

# Run the selected test file
echo "Running Testing Axis..."
bash "$test_file"
