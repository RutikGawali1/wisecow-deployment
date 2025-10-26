#!/bin/bash

echo "🧹 Cleaning up Wisecow deployment..."

# Delete Kubernetes resources
kubectl delete -f k8s/ingress.yaml --ignore-not-found=true
kubectl delete -f k8s/service.yaml --ignore-not-found=true
kubectl delete -f k8s/deployment.yaml --ignore-not-found=true
kubectl delete -f k8s/tls-secret.yaml --ignore-not-found=true

# Delete Kind cluster
kind delete cluster --name wisecow

# Remove from hosts file
sudo sed -i '/wisecow.local/d' /etc/hosts

echo "✅ Cleanup completed!"