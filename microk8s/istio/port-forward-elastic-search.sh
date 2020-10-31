#!/bin/bash

microk8s kubectl port-forward svc/elasticsearch-master 9200
