#!/bin/bash

export CLUSTER_NAME=microk8s
export NAMESPACE=tutorial
cat <<EOF > ./${NAMESPACE}-user-config.yaml
apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
    certificate-authority-data: $(microk8s kubectl get secret $(microk8s kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets.name}) -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
    server: $(microk8s kubectl config view -o jsonpath="{.clusters[?(.name==\"$(microk8s kubectl config view -o jsonpath="{.contexts[?(.name==\"$(microk8s kubectl config current-context)\")].context.cluster}")\")].cluster.server}")
  name: ${CLUSTER_NAME}-cluster

users:
- name: ${NAMESPACE}-user
  user:
    as-user-extra: {}
    client-key-data: $(microk8s kubectl get secret $(microk8s kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets..name}) -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
    token: $(microk8s kubectl get secret $(microk8s kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets..name}) -n $NAMESPACE -o jsonpath={.data.token} | base64 --decode)

contexts:
- context:
   cluster: ${CLUSTER_NAME}-cluster
   namespace: ${NAMESPACE}
   user: ${NAMESPACE}-user
  name: ${NAMESPACE}  

current-context: ${NAMESPACE}
EOF
