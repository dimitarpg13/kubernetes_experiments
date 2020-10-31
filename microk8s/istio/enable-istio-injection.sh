#!/bin/bash

microk8s kubectl label namespace default istio-injection=enabled
microk8s kubectl get namespace -L istio-injection
