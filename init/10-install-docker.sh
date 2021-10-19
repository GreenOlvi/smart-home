#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $(whoami)
rm get-docker.sh

# Install docker-compose
sudo apt-get -y install libffi-dev libssl-dev python3-dev python3 python3-pip
sudo pip3 install docker-compose

# Enable cgroups
sudo echo " cgroup_memory=1 cgroup_enable=memory" | sudo cat >> /boot/cmdline.txt
sudo echo "cgroup_enable=1" | sudo cat >> /boot/config.txt
