#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-12-28 14:26:49

export api_performance_requests_per_second_host=https://ci-cd-service.5gasp.eu
export api_performance_requests_per_second_endpoint=/manager/tests/all
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=10
python3 -m robot .
