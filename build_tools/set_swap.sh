#!/bin/bash

swapmem=$(free | awk '/^Swap:/{print $2}')
swapmemstr=$(free -h| awk '/^Swap:/{print $2}')

echo
echo "Your Current Swap Memory"
echo
echo "            $swapmemstr"
echo

if [ $swapmem -lt 4000000 ]; then
  echo
  echo "     Increasing Swap Memory..."
  echo
  grep -q "swapfile" /etc/fstab
  if [ $? -ne 0 ]; then
    echo
    echo "    Swapfile Not Found. Adding Swapfile..."
    echo
    sudo fallocate -l 4086M /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo sh -c "echo '/swapfile none swap defaults 0 0' >> /etc/fstab"
  else
    echo
    echo "    Swapfile Found. Deleting Swapfile..."
    echo 
    sudo sed -i '/swapfile/d' /etc/fstab
    sudo sh -c "echo '3' > /proc/sys/vm/drop_caches"
    sudo swapoff -a
    rm -f /swapfile
    echo
    echo "    Swapfile Deleted. Adding Swapfile..."
    echo
    sudo fallocate -l 4086M /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo sh -c "echo '/swapfile none swap defaults 0 0' >> /etc/fstab"
  fi
  swapmemstrnew=$(free -h| awk '/^Swap:/{print $2}')
  echo
  echo "Current Swap Memory"
  echo
  echo "             $swapmemstrnew"
  echo
else
  echo
  echo "     Sufficient Swap Memory... Continue..."
  echo
fi
