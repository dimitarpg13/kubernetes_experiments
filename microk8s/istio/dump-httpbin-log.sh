#!/bin/bash

microk8s kubectl logs -l app=httpbin -c istio-proxy
