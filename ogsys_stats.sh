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
lshw -class network -short | grep -vE 'serial|configuration|capacity' > network.txt
}

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
