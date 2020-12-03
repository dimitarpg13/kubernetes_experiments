#!/bin/bash

k8s_host_ip=$(cat /etc/hosts | grep 'istio\.tutorial\.bookinfo\.com' | awk '{ print $1 }')
if [[ -z $k8s_host_ip ]]; then
 echo "Kubernetes host is not found in /etc/hosts! Exitting...";
 exit -1
fi

while true; do   curl -HHost:istio.tutorial.bookinfo.com http://istio.tutorial.bookinfo.com:31380/productpage; sleep 1; done