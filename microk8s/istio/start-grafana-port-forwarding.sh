#!/bin/bash
GRAFANA_PORT_FORWARDING_LOG_FILE=grafana_port_forwarding.log
GRAFANA_PID_FILE=grafana.pid
GRAFANA_EXTERNAL_PORT=3000
GRAFANA_INSTANCE_POD=$(microk8s kubectl -n istio-system get pods | grep '^grafana' | cut -f1 -d ' ')
GRAFANA_SERVICE_PORT=$(microk8s kubectl get services -n istio-system | grep 'grafana' | sed -n 's/[^ ]* *[^ ]* *[^ ]* *[^ ]* *\([^ ]*\)\/[^ ]*.*/\1/p')
microk8s kubectl -n istio-system port-forward --address 0.0.0.0 $GRAFANA_INSTANCE_POD $GRAFANA_EXTERNAL_PORT:$GRAFANA_SERVICE_PORT > $GRAFANA_PORT_FORWARDING_LOG_FILE 2>&1 &
export GRAFANA_PORT_FORWARDING_PROCESS_ID=$!
export GRAFANA_PORT_FORWARDING_JOB_ID=$(jobs -l | grep "$GRAFANA_PORT_FORWARDING_PROCESS_ID Running" | cut -f1 -d ' ' | sed -n 's/\[\([0-9]*\)\]+/\1/p')
echo "GRAFANA_PORT_FORWARDING_PROCESS_ID=$GRAFANA_PORT_FORWARDING_PROCESS_ID" | tee $GRAFANA_PID_FILE
echo "GRAFANA_PORT_FORWARDING_JOB_ID=$GRAFANA_PORT_FORWARDING_JOB_ID" | tee -a $GRAFANA_PID_FILE
echo "GRAFANA_INSTANCE_POD=$GRAFANA_INSTANCE_POD" | tee -a $GRAFANA_PID_FILE
echo "GRAFANA_SERVICE_PORT=$GRAFANA_SERVICE_PORT" | tee -a $GRAFANA_PID_FILE
