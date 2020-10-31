#!/bin/bash

export MYHOST=$(microk8s kubectl config view -o jsonpath={.contexts..namespace}).bookinfo.com

microk8s kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: bookinfo
spec:
  rules:
  - host: $MYHOST
    http:
      paths:
      - path: /productpage
        backend:
          serviceName: productpage
          servicePort: 9080
      - path: /login
        backend:
          serviceName: productpage
          servicePort: 9080
      - path: /logout
        backend:
          serviceName: productpage
          servicePort: 9080
      - path: /static
        pathType: Prefix
        backend:
          serviceName: productpage
          servicePort: 9080
EOF
