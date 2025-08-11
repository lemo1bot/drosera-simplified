#!/bin/bash

# 🌿 Drosera Network - One-Click Setup Script
# Created by @bank_of_btc

set -e

echo "🚀 Starting Drosera Network Setup..."
echo "Created by @bank_of_btc"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root. Please run as a regular user."
   exit 1
fi

# Step 1: System Update
print_status "Step 1/8: Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System updated successfully!"

# Step 2: Install Essential Packages
print_status "Step 2/8: Installing essential packages..."
sudo apt install curl ufw git wget jq nano tmux htop unzip build-essential -y
print_success "Essential packages installed!"

# Step 3: Install Docker
print_status "Step 3/8: Installing Docker..."
# Remove old Docker versions
sudo apt remove docker.io docker-doc docker-compose -y 2>/dev/null || true

# Install Docker using official script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Test Docker
sudo docker run hello-world > /dev/null 2>&1
print_success "Docker installed and tested successfully!"

# Step 4: Install Development Tools
print_status "Step 4/8: Installing development tools..."

# Install Drosera CLI
print_status "Installing Drosera CLI..."
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup

# Install Foundry
print_status "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

# Install Bun
print_status "Installing Bun..."
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc

print_success "Development tools installed!"

# Step 5: Create Project Structure
print_status "Step 5/8: Creating project structure..."
mkdir -p ~/drosera-project/{trap,operators}
cd ~/drosera-project

print_success "Project structure created!"

# Step 6: Setup Trap
print_status "Step 6/8: Setting up your first trap..."
cd trap

# Initialize Foundry project
forge init --no-commit

# Create basic trap contract
cat > src/Trap.sol << 'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract Trap is ITrap {
    function collect() external pure returns (bytes memory) {
        return abi.encode("Hello from my trap!");
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        return (true, abi.encode("Trap responded!"));
    }
}
EOF

# Create drosera.toml
cat > drosera.toml << 'EOF'
[contract]
path = "out/Trap.sol/Trap.json"
address = ""

[response]
contract = "0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608"
function = "respond(string)"

[network]
eth_chain_id = 560048
drosera_address = "0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D"
eth_rpc_url = "https://rpc.hoodi.ethpandaops.io"
EOF

print_success "Trap setup complete!"

# Step 7: Setup Operators
print_status "Step 7/8: Setting up operators..."
cd ../operators

# Copy docker-compose file
cp ~/drosera-simplified/docker-compose.yaml .

# Create environment template
cp ~/drosera-simplified/env-template.txt .env

print_warning "Please edit the .env file with your private keys and VPS IP:"
print_warning "nano .env"

print_success "Operator setup complete!"

# Step 8: Final Instructions
print_status "Step 8/8: Setup complete! Here's what to do next:"
echo ""
print_success "✅ Setup completed successfully!"
echo ""
echo "📋 Next Steps:"
echo "1. Get Hoodi ETH from: https://faucet.hoodi.ethpandaops.io/"
echo "2. Edit operator environment: cd ~/drosera-project/operators && nano .env"
echo "3. Deploy your trap: cd ~/drosera-project/trap && forge build && DROSERA_PRIVATE_KEY=YOUR_KEY drosera apply"
echo "4. Start operators: cd ~/drosera-project/operators && docker compose up -d"
echo ""
echo "🔗 Useful Links:"
echo "- Dashboard: https://app.drosera.io"
echo "- Explorer: https://explorer.hoodi.ethpandaops.io/"
echo "- Discord: Join the Drosera community"
echo ""
echo "🐦 Follow @bank_of_btc on Twitter for updates!"
echo ""
print_warning "Don't forget to reload your shell or run: source ~/.bashrc" 