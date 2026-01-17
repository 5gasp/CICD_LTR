@echo off
REM Set Environment Variables
set availability_and_continuity_bandwidth_NEFURL= http://10.10.10.20:8888
set availability_and_continuity_bandwidth_NEFUSERNAME=admin@my-email.com
set availability_and_continuity_bandwidth_NEFPASSWORD=pass
set availability_and_continuity_bandwidth_LIVENESS=http://10.10.10.221:85

REM Run Robot Framework Test
robot availability_and_continuity_bandwidth.robot