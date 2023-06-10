#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-06-10 16:29:08

export api_performace_response_time_api_target=https://ci-cd-service.5gasp.eu/dashboard
export api_performace_response_time_api_target_threshold_ms=1000 # 1000 milliseconds = 1 second
python3 -m robot .

