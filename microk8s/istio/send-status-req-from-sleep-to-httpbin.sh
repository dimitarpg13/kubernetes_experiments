#!/bin/bash
export SOURCE_POD=$(microk8s kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})
microk8s kubectl exec "$SOURCE_POD" -c sleep -- curl -v httpbin:8000/status/418
