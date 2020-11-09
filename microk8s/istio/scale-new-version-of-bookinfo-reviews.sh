#!/bin/bash

microk8s kubectl scale deployment reviews-v2 --replicas=3
