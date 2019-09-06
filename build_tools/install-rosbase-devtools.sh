#!/bin/bash

sudo ./set_swap.sh

echo
echo "Installing ROS..."
echo

echo
echo "     Adding ROS To source.list..."
echo

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

echo
echo "     Adding ROS To source.list...  Done"
echo
echo "     Adding ROS Key..."
echo

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

echo
echo "     Adding ROS Key...  Done"
echo
echo "     Updating System..."
echo

sudo DEBIAN_FRONTEND=noninteractive apt update && sudo apt dist-upgrade -y

echo
echo "     Updating System...  Done"
echo
echo "     Installing ROS..."
echo

sudo DEBIAN_FRONTEND=noninteractive apt install -y ros-melodic-ros-base

echo
echo "     Installing ROS...  Done"
echo
echo "     Initializing ROSDEP..."
echo

sudo rosdep init
rosdep update

echo
echo "     Initializing ROSDEP...  Done"
echo
echo "     Configuring ROS Environment..."
echo

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo
echo "     Installing other dependencies..."
echo

sudo DEBIAN_FRONTEND=noninteractive apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

echo
echo "     Installing other dependencies...  Done"
echo
