#!/bin/bash

# Set the interface name
IFACE=ens3

# Disable the interface
ip link set dev $IFACE down

echo "$IFACE is now disabled."