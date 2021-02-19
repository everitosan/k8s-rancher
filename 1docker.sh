#!/bin/bash

##
## Instalación de docker
##

# Agregamos repo para tener el más actual
sudo apt-get update;
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo apt-key fingerprint 0EBFCD88;

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# instalamos docker
sudo apt-get update;
sudo apt-get install docker-ce=5:19.03.14~3-0~ubuntu-bionic docker-ce-cli=5:19.03.14~3-0~ubuntu-bionic containerd.io -y;


##
## SET USER
##
sudo useradd -m -G docker rke;
sudo runuser -l rke -c "mkdir .ssh";
sudo runuser -l rke -c "touch .ssh/authorized_keys";
