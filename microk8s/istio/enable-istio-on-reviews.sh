#!/bin/bash

curl -s https://raw.githubusercontent.com/istio/istio/release-1.8/samples/bookinfo/platform/kube/bookinfo.yaml | microk8s istioctl kube-inject -f - | microk8s kubectl apply -l app=reviews,version=v2 -f -
