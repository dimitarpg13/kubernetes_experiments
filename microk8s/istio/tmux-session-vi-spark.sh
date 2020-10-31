#!/bin/bash                                                                                                   

SESSIONNAME="vi-spark"
SPARK_EXAMPLES_PATH="git/bitnami/charts/bitnami/spark/"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SESSIONNAME -n script -d
    tmux send-keys -t $SESSIONNAME "sudo vi ${SPARK_EXAMPLES_PATH}templates/configmap-conf.yaml ${SPARK_EXAMPLES_PATH}templates/deployment-conf.yaml ${SPARK_EXAMPLES_PATH}values.yaml ${SPARK_EXAMPLES_PATH}templates/statefulset-master.yaml ${SPARK_EXAMPLES_PATH}templates/statefulset-worker.yaml" C-m 
    tmux set-option status off
fi

tmux attach -t $SESSIONNAME
