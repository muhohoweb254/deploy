#!/bin/bash
# save as update-hosts.sh

INGRESS_IP=$(kubectl get ingress -n school-app api-gateway-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

if [ -z "$INGRESS_IP" ]; then
    echo "Could not determine ingress IP"
    exit 1
fi

echo "Ingress IP: $INGRESS_IP"
echo ""
echo "Add these lines to /etc/hosts:"
echo "$INGRESS_IP   api.local"
echo "$INGRESS_IP   keycloak.local"
echo "$INGRESS_IP   springai.local"