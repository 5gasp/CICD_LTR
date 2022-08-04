# -*- coding: utf-8 -*-
# @Author: Daniel Ruiz Villa <daniel.ruiz7@um.es>
# @Date:   2022-07-22 10:31:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2022-08-02 17:29:06
# @Description: 5GASP - NetApp Surrogates - Database Ready Test

import requests
import time

WAIT_TIME = 20
MAX_TRIES = 6


def check_Database(entity_name, host_ip, port):

    print(f"Checking if {entity_name}'s database is ready...")

    requestURL = f"http://{host_ip}:{port}/checkDatabase"

    run = 0
    while run < MAX_TRIES:
        # deal with VNF iinstantiation delays
        try:
            response = requests.get(requestURL)
            response_data = response.json()

            print(f"Response data:\n{response_data}")

            if response_data is None:
                return "Error: The response is empty"
            if response_data['status'] == "OK":
                return "Success: The entity database is ready"
            else:
                return "Error: The entity database is not ready"

        except Exception as e:
            print(f"[Error] An exception was raised: {str(e)}")

        run += 1
        time.sleep(WAIT_TIME)

    return f"Error: Couldn't perform any request to {entity_name}'s API"
