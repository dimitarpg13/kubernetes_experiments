#!/bin/bash
KIALI_PORT_FORWARDING_LOG_FILE=kiali_port_forwarding.log
KIALI_PORT_FORWARDING_PID_FILE=kiali_port_forwarding.pid
KIALI_EXTERNAL_PORT=20000
KIALI_INSTANCE_POD=$(microk8s kubectl -n istio-system get pods | grep '^kiali' | cut -f1 -d ' ')
KIALI_SERVICE_PORT=$(microk8s kubectl get services -n istio-system | grep 'kiali' | sed -n 's/[^ ]* *[^ ]* *[^ ]* *[^ ]* *\([^ ]*\)\/[^ ]*.*/\1/p') 
microk8s kubectl -n istio-system port-forward --address 0.0.0.0 $KIALI_INSTANCE_POD $KIALI_EXTERNAL_PORT:$KIALI_SERVICE_PORT> $KIALI_PORT_FORWARDING_LOG_FILE 2>&1 &
export KIALI_PORT_FORWARDING_PROCESS_ID=$!
export KIALI_PORT_FORWARDING_JOB_ID=$(jobs -l | grep "$KIALI_PORT_FORWARDING_PROCESS_ID Running" | cut -f1 -d ' ' | sed -n 's/\[\([0-9]*\)\]+/\1/p')
echo "KIALI_PORT_FORWARDING_PROCESS_ID=$KIALI_PORT_FORWARDING_PROCESS_ID" | tee $KIALI_PORT_FORWARDING_PID_FILE
echo "KIALI_PORT_FORWARDING_PID_FILE=$KIALI_PORT_FORWARDING_PID_FILE" | tee -a $KIALI_PORT_FORWARDING_PID_FILE
