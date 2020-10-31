#!/bin/bash

microk8s kubectl  exec -it $(microk8s kubectl get pod -l app=sleep -o jsonpath='{.items[0].metadata.name}') -- curl http://ratings:9080/ratings/7
