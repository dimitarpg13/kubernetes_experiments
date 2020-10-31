#!/bin/bash

export REVIEWS_V2_POD_IP=$(microk8s kubectl get pod -l app=reviews_test,version=v2 -o jsonpath='{.items[0].status.podIP}')
echo $REVIEWS_V2_POD_IP
