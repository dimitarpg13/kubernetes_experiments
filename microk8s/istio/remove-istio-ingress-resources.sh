#!/bin/bash

microk8s kubectl delete -f - <<EOF
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: istio-system
  namespace: istio-system
spec:
  rules:
  - host: my-istio-dashboard.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          serviceName: grafana
          servicePort: 3000
  - host: my-istio-tracing.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          serviceName: tracing
          servicePort: 9411
  - host: my-istio-logs-database.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          serviceName: prometheus
          servicePort: 9090
  - host: my-kiali.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          serviceName: kiali
          servicePort: 20001
EOF
