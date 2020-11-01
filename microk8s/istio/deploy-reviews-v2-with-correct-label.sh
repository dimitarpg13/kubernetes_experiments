#!/bin/bash

microk8s kubectl label pods -l version=v2 app=reviews --overwrite
