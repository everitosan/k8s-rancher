# Instalación

La siguiente guía muestra los pasos para instalar un cluster de kubernetes con ayuda de rke en una máquina virtual.

## Versiones

Nodo master:
 - Docker version 19.03.13
 - helm v3.3.4
 - Kubernetes v1.18.9
 - etcd v3.4.3

Local:
 - rke version v1.1.9
 - kubectl v1.19.2


Las máquinas virtuales solo necesitan docker para poder correr el cluster con rke.

En un host aparte (maquina local) hay que instalar rke y kubectl.

---

## Instalación Cluster

Para instalar el cluster puede ejecutar el script [1-base-install.sh](docker.sh) dentro del equipo del nodo master.
```bash
$ ./docker.sh
```

Terminado el proceso deberá crear una llave **ssh** en el equipo local con el fin de poder establecer comunicación entre rke y el nodo master. 

```bash
$(local) ssh-keygen -t rsa -b 4096 
```

Para el siguiente paso deberá tener en cuenta el nombre de la llave creada así como el hostname o dirección del nodo master.


```bash
$(local) cat $HOME/.ssh/[NOMBRE_LLAVE].pub | ssh [HOSTNAME] "sudo tee -a /home/rke/.ssh/authorized_keys"
```

Lo anterior llevará la llave pública a la lista de llaves autorizadas en el nodo master.

Ahora deberá usar rke y un archivo de configuración .yml, puede usar como base el que tiene de nombre [cluster.yml](cluster.yml)

```bash
$(local) rke up
```

Terminado el proceso podra ver el archivo *kube_config_cluster.yml* que podrá usar para conectarse al cluster.

---
## Instalación Rancher

Ahora que cuenta con el cluster puede instara rancher para su administración y monitoreo.


Para esto o debrá usar el archivo *kube_config_cluster.yml* en el nodo master preferiblemente dentro de fichero **~/.kube/config**.

Puede seguir los paso descritos en *2-rancher-install.sh*, sin embargo debera contar con los archivos pertenecientes a los certificados (.cer, .key) así como el certificado con la cadena de la CA.

Terminado el proceso podrá ver el administrador de rancher en el host especificado.

---

## Referencias
- https://rancher.com/docs/rke/latest/en/installation/
- https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/
- https://rancher.com/docs/rancher/v2.x/en/cluster-admin/cleaning-cluster-nodes/