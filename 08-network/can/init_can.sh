#!/usr/bin/env bash

sudo modprobe can
sudo modprobe can_raw
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set vcan0 bitrate 100000 
sudo ip link set up vcan0
ip -details link show vcan0
