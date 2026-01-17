#!/bin/bash
export availability_and_continuity_bandwidth_NEFURL=http://10.10.10.20:8888
export availability_and_continuity_bandwidth_NEFUSERNAME=admin@my-email.com
export availability_and_continuity_bandwidth_NEFPASSWORD=pass
export availability_and_continuity_bandwidth_LIVENESS=http://10.10.10.221:85

python3 -m robot availability_and_continuity_bandwidth.robot