#!/bin/bash
#169.254.216.209
sudo ip addr flush dev eth0
sudo ip addr add 169.254.216.209/16 dev eth0
ip addr show dev eth0
sudo ip link set eth0 up
sudo ip route add default via 192.168.4.254 dev eth0
ip route show
ping 192.168.4.254
ping google.com