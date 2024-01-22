#!/bin/bash

# Set the interface name
IFACE=ens3

# Clear any existing tc rules
tc qdisc del dev $IFACE root

# Check if packet corruption percentage is provided as an argument
if [ -z "$1" ]
then
    echo "Please provide packet corruption percentage as an argument."
    exit 1
fi

# Add a new tc qdisc with the specified packet corruption
tc qdisc add dev $IFACE root netem corrupt $1%

# Display the tc configuration
tc qdisc show dev $IFACE
