# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-30 12:03:40
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-30 12:23:02
import requests
import time
from urllib.parse import urlparse, urlunparse


def start_mini_api_test(mini_api_start_endpoint_to_invoke, target):
    # Parse the base URL so we can then append the target
    parsed_url = urlparse(mini_api_start_endpoint_to_invoke)
    path_parts = parsed_url.path.rstrip('/').split('/')

    # Append the query parameter to the last path part
    path_parts[-1] += f"?target={target}"

    # Reconstruct the URL with the modified path
    mini_api_start_modified_url = urlunparse(
        parsed_url._replace(path='/'.join(path_parts))
    )

    response = requests.post(
        f"{mini_api_start_modified_url}"
    )

    if response.status_code not in [200, 201, 409]:
        return False
    print(f"START Response: {response.text}")
    return True


def stop_mini_api_test(mini_api_stop_endpoint_to_invoke):
    response = requests.post(mini_api_stop_endpoint_to_invoke)

    if response.status_code not in [200, 409]:
        return False
    print(f"STOP Response: {response.text}")
    return True


def get_results_and_evaluate_them(mini_api_results_endpoint_to_invoke, target):
    total_time_slept = 0
    try:
        # try for 3 minutes
        while total_time_slept < 180:
            # Make a GET request to the API
            response = requests.get(mini_api_results_endpoint_to_invoke)

            # Check if the request was successful (status code 200)
            if response.status_code == 200:
                json_response = response.json()
                print("Reponse", json_response)
                return json_response[str(target)]["hops_until_target"]
            else:
                time.sleep(5)
                total_time_slept += 5

        return -1

    except Exception as e:
        print(f"An error occurred: {e}")
        return -1
