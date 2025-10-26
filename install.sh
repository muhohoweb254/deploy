#!/bin/bash

# Simple Helm install script
helm uninstall school-app -n school-app 2>/dev/null
echo "Uninstalled previous release (if existed)"

helm install school-app ./kubernetes -n school-app --create-namespace
echo "Installed school-app"

kubectl get pods -n school-app