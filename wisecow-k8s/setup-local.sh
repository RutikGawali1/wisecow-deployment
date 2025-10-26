#!/bin/bash
set -e

echo "🚀 Setting up Wisecow Kubernetes deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    print_status "Installing Kind..."
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    print_error "kubectl is not installed. Please install kubectl first."
    exit 1
fi

# Create Kind cluster
print_status "Creating Kind cluster..."
kind create cluster --name wisecow --config kind-config.yaml

# Wait for cluster to be ready
print_status "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready node/wisecow-control-plane --timeout=60s

# Install NGINX Ingress Controller
print_status "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Wait for ingress controller to be ready
print_status "Waiting for Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

# Generate TLS certificates
print_status "Generating TLS certificates..."
chmod +x ssl/generate-certs.sh
./ssl/generate-certs.sh

# Create TLS secret in Kubernetes
print_status "Creating TLS secret in Kubernetes..."
kubectl apply -f k8s/tls-secret.yaml

# Build Docker image
print_status "Building Docker image..."
docker build -t wisecow:latest .

# Load image into Kind cluster
print_status "Loading Docker image into Kind cluster..."
kind load docker-image wisecow:latest --name wisecow

# Deploy application
print_status "Deploying Wisecow application..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

# Wait for deployment to be ready
print_status "Waiting for deployment to be ready..."
kubectl rollout status deployment/wisecow-deployment --timeout=120s

# Update hosts file
print_status "Updating /etc/hosts file (you may need to run this with sudo)..."
echo "127.0.0.1 wisecow.local" | sudo tee -a /etc/hosts

# Get ingress details
print_status "Getting ingress details..."
kubectl get ingress

# Print success message
echo ""
echo -e "${GREEN}✅ Deployment completed successfully!${NC}"
echo ""
echo "📋 Access URLs:"
echo "   HTTPS: https://wisecow.local"
echo ""
echo "🔧 Verification commands:"
echo "   kubectl get pods,svc,ingress"
echo "   curl -k https://wisecow.local"
echo ""
echo "📝 To view logs:"
echo "   kubectl logs -l app=wisecow --tail=10"
echo ""
echo "🛑 To clean up:"
echo "   ./cleanup.sh"