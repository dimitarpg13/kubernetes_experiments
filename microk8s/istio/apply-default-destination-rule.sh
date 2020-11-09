#!/bin/bash

microk8s kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/networking/destination-rule-all.yaml
