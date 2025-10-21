#!/bin/bash

#************************************#
#******* OUTPUT SYSTEM STATS ********#
#************************************#

# Create and enter System_Stats directory
mkdir -p System_Stats
cd System_Stats || exit

# Output kernel info
{
  uname
  sudo lshw -short
  sudo lshw -html > lshw.html
  lscpu
} > kernel.txt

# Output network info
{
  echo "Network Interfaces:"
  echo "==================="

  ip -brief address

  echo
  echo "Interface Details (sanitized):"
  echo "=============================="

  for iface in $(ls /sys/class/net); do
    echo "Interface: $iface"
    cat /sys/class/net/"$iface"/operstate
    cat /sys/class/net/"$iface"/mtu
    echo
  done
} > network.txt



# Output disk info
{
  echo "<html>"
  df -h
  echo "</html>"
} > disk.html

# Output CPU info
{
  lscpu | head -n 5
  echo
  lscpu | tail -n 12
} > cpu.txt

# Output block device info
{
  lsblk -o NAME,SIZE,TYPE -a --ascii
} > block_dev.txt

# Output SATA device info
{
  lsblk -o NAME,SIZE,TYPE,TRAN --ascii | grep 'sata'

  for dev in $(lsblk -d -o NAME,TRAN | awk '$2 == "sata" {print $1}'); do
    udevadm info --query=all --name="/dev/$dev"
  done
} > sata.txt
