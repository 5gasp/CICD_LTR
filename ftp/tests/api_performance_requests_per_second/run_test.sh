#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:48:27

export api_performance_requests_per_second_host=https://community.5gasp.eu
export api_performance_requests_per_second_endpoint=/index.php/category/blog/
export api_performance_requests_per_second_http_method=GET
export api_performance_requests_per_second_min_threshold=10
python3 -m robot .
