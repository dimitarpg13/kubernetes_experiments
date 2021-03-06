snap install microk8s --classic
sudo ufw default allow routed
sudo iptables -P FORWARD ACCEPT

microk8s.enable dns dashboard metrics-server
# grafana/dashboard
# http://IP:8080/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy/
# http://IP:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/pod?namespace=default

microk8s.enable istio

snap alias microk8s.kubectl kubectl

kubectl label namespace default istio-injection=enabled
# say yes when tls question shows up
kubectl create -f https://raw.githubusercontent.com/istio/istio/release-1.6/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl create -f https://raw.githubusercontent.com/istio/istio/release-1.6/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.6/samples/bookinfo/networking/destination-rule-all-mtls.yaml

# product page -http://IP:31380/productpage
kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}'

# istio metrics - http://IP:3000
kubectl -n istio-system port-forward --address 0.0.0.0 $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000
# istio tracing - http://IP:16686
kubectl -n istio-system port-forward --address 0.0.0.0 $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686
# istio mesh - http://IP:8088/force/forcegraph.html
kubectl -n istio-system port-forward --address 0.0.0.0 $(kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}') 8088:8088

## intelligent routing
# Notice that the reviews part of the page displays with no rating stars
# kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.0/samples/bookinfo/networking/virtual-service-all-v1.yaml
# login as jason || login as caglar
# kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.0/samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
# kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.0/samples/bookinfo/networking/virtual-service-all-v1.yaml

snap unalias kubectl
