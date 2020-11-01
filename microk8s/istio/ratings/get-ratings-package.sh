#!/bin/bash

curl -s https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/src/ratings/ratings.js -o ratings.js

curl -s https://raw.githubusercontent.com/istio/istio/release-1.7/samples/bookinfo/src/ratings/package.json -o package.json
