# -*- coding: utf-8 -*-
# @Author: Luka Korsic
# @Date:   2023-06-10 16:09:37
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:50:04
import time
import requests


def response_time(target):
    try:
        start_time = time.time()
        result = requests.get(target)

        if result.status_code == 500:
            return "Fail: Server error"

        if result.status_code == 200 and result.text != "-1":

            # Debug
            response_time = time.time() - start_time
            print(target)
            print(result.status_code)
            print(result.text[:300])
            print('...')
            print('Response time:', str(response_time))
   
            # returns milliseconds
            return response_time * 1000

        else:
            return "Fail: The target endpoint not reachable."
        
    except Exception as e:
        return "Fail: Unknown test error - " + str(e)

if __name__ == "__main__":
    print(response_time("https://ci-cd-service.5gasp.eu/dashboard"))