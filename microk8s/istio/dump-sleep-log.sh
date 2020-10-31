#!/bin/bash

microk8s kubectl logs -l app=sleep -c istio-proxy
