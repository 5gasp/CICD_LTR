#!/bin/bash

# Set the interface name
IFACE=ens3

# Disable the interface
ip link set dev $IFACE up

echo "$IFACE is now enabled."
