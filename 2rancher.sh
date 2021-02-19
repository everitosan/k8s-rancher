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
##  USANDO UN CA propio así como los certificados propios del gir.dev.sat.gob.mx
## Añadimos certificados.
kubectl -n cattle-system create secret tls tls-rancher-ingress --cert=gir.cer --key=gir.key
kubectl -n cattle-system create secret generic tls-ca --from-file=cacerts.pem=./CA.pem
## Instalamos rancher
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=gir.dev.sat.gob.mx --set ingress.tls.source=secret --set privateCA=true
## Esperamos al deploy
kubectl -n cattle-system rollout status deploy/rancher
