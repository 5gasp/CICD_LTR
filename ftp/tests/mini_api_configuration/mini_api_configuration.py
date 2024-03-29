# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-13 15:34:19
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-02-04 11:50:07

# Return Codes:
# 0 - Success (PASS)
# 1 - Test Failed due to errors in the authentication process
# 2 - Test Failed due to an exception


import requests
import json


def perform_mini_api_configuration(
    mini_api_configuration_url, configuration_payload
):
    response = None
    try:
        print("Configuration Payload:", configuration_payload)
        headers = {}
        headers["Content-Type"] = "application/json"
        response = requests.post(
            url=mini_api_configuration_url,
            headers=headers,
            data=configuration_payload,
        )
        if response.status_code not in [200, 409]:
            response.raise_for_status()
        print(f"Response: {response.text}")
        return 0, "OK"

    except Exception as e:
        error = response.text if response else None
        print(f"Error: {error} - {e}")
        return 1, error
