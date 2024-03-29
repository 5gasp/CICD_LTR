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


def validate_report(report):
    errors = []
    for i in range(len(report)-1, -1, -1):
        request = report[i]
        if request["endpoint"] == "/api/v1/3gpp-monitoring-event/v1/netapp/subscriptions" and request["method"] == "POST":
            print("Request: ", request)
            if request["nef_response_code"] not in [200, 409]:
                errors.append("Invalid Login")
                break
        # Other validations...
        # here
    return errors


def test_monitoring_subscription(mini_api_endpoint_to_invoke, reporting_api_ip, 
                            reporting_api_port):

    # 1. Trigger MiniAPIs endpoint
    response = None
    try:
        response =  requests.post(mini_api_endpoint_to_invoke)
    
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(f"Response: {response.text}")
    except Exception as e:
        error = response.text if response else None
        print(f"Error: {error} - {e}")
        return 2, error

    # 2. Get NEF's Report
    try:
        url = f"http://{reporting_api_ip}:{reporting_api_port}/report"
        response = requests.get(url)
    
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(f"Response: {response.text}")
        report_json = json.loads(response.text)
        print("NEF's Obtained Report: ")
        print(json.dumps(report_json, indent=4))
        
        errors = validate_report(report_json)
        
    except Exception as e:
        error = response.text if response else None
        print(f"Error: {error} - {e}")
        return 2, error


    # 3. Validate Report
    errors = validate_report(report_json)

    if len(errors) != 0:
        errors_str = '\n\t- '.join(errors)
        print(f"Test Failed due to the following errors: {errors_str}")
        return 1, f"Test Failed due to the following errors: {errors_str}"

    print("Test Successful! NApp was able to subscribe a monitoring event in "\
        "the  NEF")
    return 0, "Test Successful! NApp was able to subscribe a monitoring "\
        "event in the  NEF"