#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-12-28 10:01:32
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-04 10:10:59

export nef_signaling_performance_response_time_test_host=https://webhook.site
export nef_signaling_performance_response_time_test_endpoint=/a0399d20-64db-4194-985e-ff447772e4d8
export nef_signaling_performance_response_time_test_max_response_time_threshold_secs=2
python3 -m robot .
