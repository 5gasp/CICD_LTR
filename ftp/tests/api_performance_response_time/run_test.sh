#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:49:25

export api_performance_response_time_api_target=https://google.pt
export api_performance_response_time_threshold_ms=1000 # 1000 milliseconds = 1 second
python3 -m robot .

