#!/bin/bash

#************************************#
#******* OUTPUT SYSTEM STATS ********#
#************************************#

# Make a directory called System_Stats and change directories to that directory
mkdir System_Stats
cd System_Stats || exit
# Try to make the output for each file look as neat and organized as you can.

# Output the following information to a file called kernel
touch kernel.txt
    # 1. Kernel Name
   {
    uname
    # 2. Kernel Release
    sudo lshw -short
    # 3. Kernel Version
    sudo lshw -html > lshw.html 
    # 4. The operating system
    lscpu
    } > kernel


# Output the following information to a file called network
touch network.txt
    # 1. Do not print any serial numbers or sensitive information related to the system
    # 2. All network interfaces
    {
    netstat
    } > network
    
# Output the following information to a file called disk.html
touch disk.html
    # 1. All disks
    {
    df -h
    } > disk.html
    # 2. The output should include html tags, i.e. <html></html>
    


# Output the following information to a file called cpu
    # 1. The first five lines of the command lscpu
    # 2. The last 12 lines of the command lscpu
  {  
  lscpu | head -n 5
  echo
  lscpu | tail -n 12
} > cpu


# Output the following information to a file called block_dev
    # 1. Only the name, size, and type of the block devices
    # 2. The output should use ascii characters for any tree formatting
    {
    lsblk -o NAME,SIZE,TYPE -a --ascii 
   } > System_Stats/block_dev

    {
  lsblk -o NAME,SIZE,TYPE,TRAN --ascii | grep 'sata'

  for dev in $(lsblk -d -o NAME,TRAN | awk '$2 == "sata" {print $1}'); do
    udevadm info --query=all --name="/dev/$dev"
  done
} > sata

    
    





    
