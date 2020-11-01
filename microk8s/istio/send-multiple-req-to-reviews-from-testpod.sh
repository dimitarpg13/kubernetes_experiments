#!/bin/bash

REVIEWS_V2_POD_IP=$(microk8s kubectl get pod -l app=reviews_test,version=v2 -o jsonpath='{.items[0].status.podIP}')

microk8s kubectl exec -it $(microk8s kubectl get pod -l app=sleep -o jsonpath='{.items[0].metadata.name}') -- sh -c "for i in 1 2 3 4 5 6 7 8 9 10; do curl -o /dev/null -s -w '%{http_code}\n' $REVIEWS_V2_POD_IP:9080/reviews/7; done"
