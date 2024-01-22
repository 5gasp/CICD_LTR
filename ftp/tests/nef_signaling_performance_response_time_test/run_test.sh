#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:42:37

export nef_signaling_performance_response_time_test_host=https://webhook.site
export nef_signaling_performance_response_time_test_endpoint=/30f999bf-09c9-4b28-9857-dbfd4489d42f
export nef_signaling_performance_response_time_test_max_response_time_threshold_secs=2
python3 -m robot .
