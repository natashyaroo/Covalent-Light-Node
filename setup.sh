#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored status messages
print_status() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_error() {
    echo -e "${RED}[!]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root (use sudo)"
    exit 1
}

# Function to check if a command was successful
check_status() {
    if [ $? -eq 0 ]; then
        print_status "$1 successful"
    else
        print_error "$1 failed"
        exit 1
    fi
}

# Welcome message
echo "================================================="
echo "    EWM-DAS Light Client Installation Script"
echo "================================================="

# Install required packages
print_status "Installing required packages..."
apt-get update
apt-get install -y wget git docker.io
check_status "Package installation"

# Install GO
print_status "Installing GO..."
wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
check_status "GO installation"

# Configure GO environment
print_status "Configuring GO environment..."
echo "" >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOBIN=$GOPATH/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$GOBIN' >> ~/.bashrc
source ~/.bashrc
check_status "GO configuration"

# Install IPFS Kubo Client
print_status "Installing IPFS Kubo Client..."
wget https://dist.ipfs.tech/kubo/v0.30.0/kubo_v0.30.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.30.0_linux-amd64.tar.gz
check_status "IPFS Kubo installation"

# Clone Repository
print_status "Cloning EWM-DAS repository..."
git clone https://github.com/covalenthq/ewm-das
cd ewm-das
check_status "Repository cloning"

# Build Docker Image
print_status "Building Docker image..."
docker build -t covalent/light-client -f Dockerfile.lc .
check_status "Docker image build"

# Prompt for private key
echo
print_warning "Please enter your hex private key:"
read -s PRIVATE_KEY

if [ -z "$PRIVATE_KEY" ]; then
    print_error "Private key cannot be empty"
    exit 1
fi

# Run Docker Container
print_status "Starting Docker container..."
docker run -d --restart always --name light-client -e PRIVATE_KEY="$PRIVATE_KEY" covalent/light-client
check_status "Docker container startup"

# Cleanup
print_status "Cleaning up installation files..."
cd ..
rm -f go1.22.3.linux-amd64.tar.gz
rm -f kubo_v0.30.0_linux-amd64.tar.gz
check_status "Cleanup"

echo
echo "================================================="
print_status "Installation completed successfully!"
echo "================================================="
echo
print_status "Your light client is now running in a Docker container"
print_status "To check the status, use: docker ps"
print_status "To view logs, use: docker logs light-client"
echo "================================================="