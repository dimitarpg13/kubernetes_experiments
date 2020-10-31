#!/bin/bash

microk8s kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/sleep/sleep.yaml

export SOURCE_POD=$(microk8s kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})
