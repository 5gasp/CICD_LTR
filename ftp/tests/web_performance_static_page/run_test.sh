#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2023-06-10 16:23:45

export web_performance_static_page_target=https://ci-cd-service.5gasp.eu/dashboard
export web_performance_static_page_web_speed_net_threshold_bps=5000000 #5 MBs per second
python3 -m robot .