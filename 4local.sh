#!/bin/bash


# Instalación kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl";
chmod +x kubectl;
mv kubectl /usr/local/bin;


# Instalación rke
wget https://github.com/rancher/rke/releases/download/v1.1.9/rke_linux-amd64;
chmod +x rke_linux-amd64;
mv rke_linux-amd64 rke;
mv rke /usr/local/bin;
