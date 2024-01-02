# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-29 16:40:46
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-02 20:19:31
import requests
from urllib.parse import urlparse, urlunparse
import time

def start_server_mini_api(mini_api_start_endpoint_to_invoke):

    parsed_url = urlparse(mini_api_start_endpoint_to_invoke)
    path_parts = parsed_url.path.rstrip('/').split('/')

    # Append the query parameter to the last path part
    # Since some miniAPIs will run inside CNFs, it is difficult to expose the
    # iperf server if it is located there. Therefore, we launch the iperf
    # server in the 'UE' which is a VM inside the 5G Network running the
    # Mini API 
    path_parts[-1] += "?is_server=true"

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


def stop_server_mini_api(mini_api_stop_endpoint_to_invoke):
    response = requests.post(mini_api_stop_endpoint_to_invoke)

    if response.status_code not in [200, 201, 409]:
        return False
    print(f"START Response: {response.text}")
    return True


def start_client_mini_api(
    mini_api_start_endpoint_to_invoke, target_ip, ue_count
):

    parsed_url = urlparse(mini_api_start_endpoint_to_invoke)
    path_parts = parsed_url.path.rstrip('/').split('/')

    # Append the query parameter to the last path part
    # Since some miniAPIs will run inside CNFs, it is difficult to expose the
    # iperf server if it is located there. Therefore, we launch the iperf
    # server in the 'UE' which is a VM inside the 5G Network running the
    # Mini API 
    path_parts[-1] += f"?target_ip={target_ip}&ue_count={ue_count}"

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


def get_results_and_evaluate_them(mini_api_results_endpoint_to_invoke):
    # We will try to get the results for 3 minutes
    total_time_slept = 0
    while total_time_slept < 180:
        try:
            # Make a GET request to the API
            response = requests.get(mini_api_results_endpoint_to_invoke)

            # Check if the request was successful (status code 200)
            if response.status_code == 200:
                json_response = response.json()
                print("Reponse", json_response)
                return (
                    json_response["throughput_mbps"],
                    json_response["mean_rtt_ms"],
                )
            else:
                raise Exception(
                    f"Request failed with status code: {response.status_code}"
                )
        except Exception as e:
            print(f"An error occurred: {e}.\nWill sleep for 5 seconds...")
            time.sleep(5)
            total_time_slept += 5
