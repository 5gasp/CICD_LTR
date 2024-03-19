#!/bin/bash
export availability_and_continuity_latency_NEFURL=http://10.10.10.20:8888
export availability_and_continuity_latency_NEFUSERNAME=admin@my-email.com
export availability_and_continuity_latency_NEFPASSWORD=pass
export availability_and_continuity_latency_LIVENESS=http://10.10.10.221:85

python3 -m robot availability_and_continuity_latency.robot