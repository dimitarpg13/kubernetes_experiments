#!/bin/bash

curl -s https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/platform/kube/bookinfo.yaml | microk8s istioctl kube-inject -f - | sed 's/replicas: 1/replicas: 3/g' | microk8s kubectl apply -l app=productpage,version=v1 -f -
