#!/bin/bash

NAMESPACE=tutorial
microk8s kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${NAMESPACE}-user
  namespace: $NAMESPACE
EOF
