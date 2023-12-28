#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-28 11:40:12

export api_performance_requests_per_second_host=https://atnog-harbor.av.it.pt
export api_performance_requests_per_second_endpoint=/
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=50
python3 -m robot .

