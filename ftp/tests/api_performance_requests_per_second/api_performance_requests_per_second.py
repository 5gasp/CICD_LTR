# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-28 10:45:52
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-28 11:14:29
import json
import statistics


def evaluate_locust_results(results_json):
    # Print the results
    print("LOCUST RESULTS:")
    print(results_json)

    # Load the locust results and compute the final test result
    results = json.loads(results_json)[0]

    num_requests_per_second = [
        v
        for v
        in results["num_reqs_per_sec"].values()
    ]

    print(f"Test Duration: {len(num_requests_per_second)} seconds.")

    mean_requests_per_second = statistics.mean(num_requests_per_second)
    print("Mean Requests per Second:", mean_requests_per_second)

    median_requests_per_second = statistics.median(num_requests_per_second)
    print("Median Requests per Second:", median_requests_per_second)

    # Return the final result
    return median_requests_per_second
