#!/bin/bash

# Set the interface name
IFACE=ens3

# Delete the tc qdisc, which removes the packet loss setting
tc qdisc del dev $IFACE root

# Display the tc configuration
tc qdisc show dev $IFACE