#!/bin/bash

sudo microk8s kubectl port-forward --namespace default svc/my-spark-3-master-svc 8001:80
