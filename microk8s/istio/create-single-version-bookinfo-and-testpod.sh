#!/bin/bash

export MYHOST=$(microk8s kubectl config view -o jsonpath={.contexts..namespace}).bookinfo.com

microk8s kubectl apply -l version!=v2,version!=v3 -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/platform/kube/bookinfo.yaml

