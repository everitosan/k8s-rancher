#!/bin/bash

# instalación de heml
sudo snap install helm --classic

# Instalación kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl";
chmod +x kubectl;
mv kubectl /usr/local/bin;

# agregamos repo a heml
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update

## Antes de correr esta linea hay que setear el archivo de config apara kubectl
kubectl create namespace cattle-system

##
##  USANDO CERTIFICADOS DE RANCHER
## Instalamos cert-manager
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4
## Verify
kubectl get pods --namespace cert-manager

## instalamos rancher
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org
## Verify
kubectl -n cattle-system rollout status deploy/rancher
