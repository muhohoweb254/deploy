#!/bin/bash

set -e

NAMESPACE="school-app"
RELEASE_NAME="school-app"
CHART_PATH="./"

echo "📦 Upgrading/Installing $RELEASE_NAME..."
helm upgrade --install $RELEASE_NAME $CHART_PATH \
    -n $NAMESPACE \
    --create-namespace \
    --wait \
    --timeout 15m \
    --wait-for-jobs \
    --atomic

echo "✅ Deployment complete!"
echo ""
echo "📊 Pod Status:"
kubectl get pods -n $NAMESPACE

echo ""
echo "🗄️ Storage Status:"
kubectl get pv,pvc -n $NAMESPACE