#!/bin/sh

DISTRI=`cat /etc/*release | grep DISTRIB_RELEASE | awk -F= '{print $2}'`
sudo apt-get remove docker docker-engine
if [ ${DISTRI} = '14.04' ];then
	sudo apt-get update
	sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
fi
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce

# nvidia-docker
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
