# -*- coding: utf-8 -*-
# @Author: Rafael Direito
# @Date:   2023-03-13 15:34:19
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-05-22 15:48:29

# Return Codes:
# 0 - Success (PASS)
# 1 - Test Failed due to errors in the authentication process
# 2 - Test Failed due to an exception


import requests


def perform_report_api_configuration(api_ip, api_port):
    response = None
    try:
        url = f"http://{api_ip}:{api_port}/report"
        response = requests.post(url)
    
        if response.status_code not in [200, 409]:
            response.raise_for_status()    
        print(f"Response: {response.text}")
        return 0, "OK"

    except Exception as e:
        error = response.text if response else None
        print(f"Error: {error} - {e}")
        return 1, error
