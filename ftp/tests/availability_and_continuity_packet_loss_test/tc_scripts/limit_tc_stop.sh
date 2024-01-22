#!/bin/bash
sudo tc class del dev ifb0 parent 1:1 classid 1:10 htb rate 1mbit
sudo tc class del dev ifb0 parent 1: classid 1:1 htb rate 1mbit
sudo tc qdisc del dev ifb0 root handle 1: htb default 10
sudo tc class del dev ens3 parent 1:1 classid 1:10 htb rate 1mbit
sudo tc class del dev ens3 parent 1: classid 1:1 htb rate 1mbit
sudo tc qdisc del dev ens3 root handle 1: htb default 10
#sudo tc filter del dev ens3 parent ffff: protocol ip u32 match u32 0 0 action mirred egress redirect dev ifb0
sudo tc qdisc del dev ens3 handle ffff: ingress
sudo ip link set dev ifb0 down # repeat for ifb1, ifb2, ...
sudo modprobe -r ifb