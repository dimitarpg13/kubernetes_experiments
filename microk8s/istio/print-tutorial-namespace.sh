#!/bin/bash

echo $(microk8s kubectl config view -o jsonpath="{.contexts[?(@.name == \"$(microk8s kubectl config current-context)\")].context.namespace}")
