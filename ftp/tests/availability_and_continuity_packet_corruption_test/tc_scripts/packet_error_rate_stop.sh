#!/bin/bash

# Set the interface name
IFACE=ens3

# Delete the tc qdisc with packet corruption
tc qdisc del dev $IFACE root netem

# Display the tc configuration
tc qdisc show dev $IFACE
