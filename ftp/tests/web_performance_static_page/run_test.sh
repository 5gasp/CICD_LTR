#!/bin/bash
# @Author: Rafael Direito
# @Date:   2023-05-22 15:42:35
# @Last Modified by:   Rafael Direito
# @Last Modified time: 2024-01-22 16:46:59

export web_performance_static_page_target=https://google.pt
export web_performance_static_page_web_speed_net_threshold_bps=5000000 #5 MBs per second
python3 -m robot .