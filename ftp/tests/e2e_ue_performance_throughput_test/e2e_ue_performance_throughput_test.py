# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-13 15:34:19
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-31 09:48:04

# Return Codes:
# 0 - Success (PASS)
# 1 - Test Failed due to errors in the authentication process
# 2 - Test Failed due to an exception


import requests
import json
from time import sleep
import statistics as stats


def validate_report(results, minimal_threshold):
    errors = []
    
    
    total_bytes_transferred = results['end']['sum_sent']['bytes']

    total_duration = results['start']['test_start']['duration']
    average_throughput = total_bytes_transferred / total_duration
    average_throughput_mbps = (average_throughput / 1e6) * 8
    if average_throughput_mbps < float(minimal_threshold):
         errors.append("Minimal  Required Throughput has not been reached")
    # # Print the results

    return errors


def test_e2e_ue_performance(mini_api_endpoint_to_invoke_server, mini_api_endpoint_to_invoke_client,
                            mini_api_endpoint_to_invoke_results, mini_api_endpoint_to_invoke_cleanup,
                            e2e_ue_performance_test_threshold):

   
    response = None
    try:
        # 1. Trigger MiniAPIs endpoint to Start Server
        response =  requests.post(mini_api_endpoint_to_invoke_server)
    
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(f"Response: {response.text}")

        # 2. Trigger MiniAPIs endpoint to Start Client
        response = None
        
        response =  requests.post(mini_api_endpoint_to_invoke_client)

        if response.status_code not in [200, 409]:
            response.raise_for_status()    
    
        # 3. Get MINIAPI's Results
        sleep(5)
        url = mini_api_endpoint_to_invoke_results
        response = requests.get(url)
        print("...")
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(response.status_code)
        report_json = response.json()
        print(f"Response: {report_json}")
        print("Performance Test Result: ")
        print(json.dumps(report_json, indent=4))
        
        # 3. Validate Report
        errors = validate_report(report_json, e2e_ue_performance_test_threshold)

        if len(errors) != 0:
            errors_str = '\n\t- '.join(errors)
            print(f"Test Failed due to the following errors: {errors_str}")
            return 1, f"Test Failed due to the following errors: {errors_str}"
        
        # 
        # 4 Clean Testing Environment
        response =  requests.post(mini_api_endpoint_to_invoke_cleanup)
    
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(f"Response: {response.text}")
    except Exception as e:
        error = response.text if response else None
        print(f"Error: {error} - {e}")
        return 2, error


    print("Test Successful! The E2E Performance Throughput between the NApp's UEs has"\
        " been validated")
    return 0, "Test Successful! The E2E Performance Throughput between the NApp's UEs has"\
        " been validated"

