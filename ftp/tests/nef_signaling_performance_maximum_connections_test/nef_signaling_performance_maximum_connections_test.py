# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-12-29 16:40:46
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-29 17:14:40
import requests


def start_mini_api_test(mini_api_start_endpoint_to_invoke):
    response = requests.post(mini_api_start_endpoint_to_invoke)

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


def get_results_and_evaluate_them(mini_api_results_endpoint_to_invoke):
    maximum_number_of_connections = 0
    print("Connections recording file content:")
    try:
        # Make a GET request to the API
        response = requests.get(mini_api_results_endpoint_to_invoke)

        # Check if the request was successful (status code 200)
        if response.status_code == 200:
            # Iterate through each line in the response text and print it
            for line in response.text.splitlines():
                print(line)
                try:
                    connections = int(line.strip())
                    if connections > maximum_number_of_connections:
                        maximum_number_of_connections = connections
                except Exception:
                    pass
            return maximum_number_of_connections
        else:
            print(f"Error: {response.status_code} - {response.text}")
            return -1

    except Exception as e:
        print(f"An error occurred: {e}")
        return -1
