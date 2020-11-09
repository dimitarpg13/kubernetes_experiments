#!/bin/bash

curl https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/platform/kube/cleanup.sh --output bookinfo-kube-cleanup.sh

chmod 777 ./bookinfo-kube-cleanup.sh

microk8s kubectl get virtualservices   #-- there should be no virtual services
microk8s kubectl get destinationrules  #-- there should be no destination rules
microk8s kubectl get gateway           #-- there should be no gateway
microk8s kubectl get pods              #-- the Bookinfo pods should be deleted
