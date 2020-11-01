#!/bin/bash

curl -s https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/platform/kube/bookinfo.yaml | sed 's/app: reviews/app: reviews_test/' | microk8s kubectl apply -l app=reviews_test,version=v2 -f -
