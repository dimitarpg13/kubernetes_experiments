#!/bin/bash

for pod in $(microk8s kubectl get pods -l app=details -o jsonpath='{.items[*].metadata.name}'); do echo terminating $pod; microk8s kubectl exec -it $pod -- pkill ruby; done
