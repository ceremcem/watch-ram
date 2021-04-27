#!/bin/bash

echo "Date: `date -u`"
echo
echo "Processes:"
sudo ./ps_mem.py | tail -n 10
echo
echo "LXC:"
sudo ./lxc-info-ram
echo
echo "Memory:"
free -h
echo
