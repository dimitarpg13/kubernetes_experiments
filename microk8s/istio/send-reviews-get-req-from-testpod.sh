#!/bin/bash

REVIEWS_V2_POD_IP=$(microk8s kubectl get pod -l app=reviews_test,version=v2 -o jsonpath='{.items[0].status.podIP}')
microk8s kubectl exec -it $(microk8s kubectl get pod -l app=sleep -o jsonpath='{.items[0].metadata.name}') -- curl $REVIEWS_V2_POD_IP:9080/reviews/7
