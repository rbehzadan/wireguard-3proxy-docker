#!/bin/bash

# Start WireGuard
wg-quick up /etc/wireguard/wg0.conf

# Wait for WireGuard interface to be up
sleep 1

exec /usr/local/bin/3proxy /etc/3proxy/3proxy.cfg
