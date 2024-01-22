#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:44:06

export nef_signaling_performance_requests_per_second_test_host=https://webhook.site
export nef_signaling_performance_requests_per_second_test_endpoint=/30f999bf-09c9-4b28-9857-dbfd4489d42f
export nef_signaling_performance_requests_per_second_test_min_threshold=5
python3 -m robot .