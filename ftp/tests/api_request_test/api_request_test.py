# -*- coding: utf-8 -*-
# @Author: Daniel Ruiz Villa <daniel.ruiz7@um.es>
# @Date:   2022-07-22 10:31:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2022-08-02 17:29:03
# @Description: 5GASP - NetApp Surrogates - API Request Ready Tes

import requests
import time


WAIT_TIME = 20
MAX_TRIES = 6


def get_Resource(host_ip, port):
    print(host_ip, port)
    requestURL = f"http://{host_ip}:{port}/ready"
    
    run = 0
    while run < MAX_TRIES:
        try:
            response = requests.get(requestURL)
            response_data = response.json()

            print(response_data)
            if not response_data:
                return "Error: The response is empty"
            if response_data['status'] == "OK":
                return "Success: The entity server is ready"
            else:
                return "Error: The entity server is not ready"

        except Exception as e:
            print(f"Error! Excpetion was raised: {e}")

        run += 1
        time.sleep(WAIT_TIME)
