#!/bin/bash

microk8s kubectl apply -l app=reviews,version=v2 -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/platform/kube/bookinfo.yaml
