#!/bin/bash

echo $(microk8s kubectl get ingress istio-system -n istio-system -o jsonpath='{..ip} {..host}') $(microk8s kubectl get ingress bookinfo -o jsonpath='{..host}')
