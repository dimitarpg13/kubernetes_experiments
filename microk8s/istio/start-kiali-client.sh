#!/bin/bash
KIALI_DASHBOARD_PID_FILE=kiali_dashboard.pid
KIALI_DASHBOARD_CLIENT_LOG_FILE=kiali_dashboard_client.log
microk8s istioctl dashboard kiali > $KIALI_DASHBOARD_CLIENT_LOG_FILE 2>&1 &
export KIALI_CLIENT_PROCESS_ID=$!
export KIALI_CLIENT_JOB_ID=$(jobs -l | grep "$KIALI_CLIENT_PROCESS_ID Running" | cut -f1 -d ' ' | sed -n 's/\[\([0-9]*\)\]+/\1/p')
echo "KIALI_CLIENT_PROCESS_ID=$KIALI_CLIENT_PROCESS_ID" | tee $KIALI_DASHBOARD_PID_FILE
echo "KIALI_CLIENT_JOB_ID=$KIALI_CLIENT_JOB_ID" | tee -a $KIALI_DASHBOARD_PID_FILE
