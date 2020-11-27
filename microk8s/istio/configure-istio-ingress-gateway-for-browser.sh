#!/bin/bash

export NAMESPACE=$(microk8s kubectl config view -o jsonpath="{.contexts[?(@.name == \"$(microk8s kubectl config current-context)\")].context.namespace}")

export MY_INGRESS_GATEWAY_HOST=istio.$NAMESPACE.bookinfo.com

microk8s kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
spec:
  hosts:
  - "*"
  gateways:
  - bookinfo-gateway.$NAMESPACE.svc.cluster.local
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /static
    route:
    - destination:
        host: productpage
        port:
          number: 9080
EOF

external_ip_value=$(microk8s kubectl get svc istio-ingressgateway -n istio-system | awk '{print $4}' | sed -e '/EXTERNAL-IP/d')

if [[ "$external_ip_value" = "" ||  "$external_ip_value" = "<pending>" || "$external_ip_value" = "<none>" ]]; then
  echo "Accessing the Istio ingress gateway as NodePort..."
  export INGRESS_PORT=$(microk8s kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
  export SECURE_INGRESS_PORT=$(microk8s kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
  export TCP_INGRESS_PORT=$(microk8s kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
  export INGRESS_HOST=$(microk8s kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
fi	
