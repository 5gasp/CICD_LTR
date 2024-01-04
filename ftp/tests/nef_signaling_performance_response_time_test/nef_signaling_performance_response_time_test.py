# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-28 10:45:52
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-04 10:10:44
import json


def evaluate_locust_results(results_json):
    # Print the results
    print("LOCUST RESULTS:")
    print(results_json)

    # Load the locust results and compute the final test result
    results = json.loads(results_json)[0]

    total_requests = results["num_requests"] - results["num_failures"]
    print(f"Number of requests made: {total_requests}.")

    total_response_time = results["total_response_time"] / 1000
    print(f"Total Response Time: {total_response_time} sec.")

    avg_response_time = total_response_time / total_requests

    # Return the final result
    return avg_response_time
