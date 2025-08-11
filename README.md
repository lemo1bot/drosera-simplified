# 🌿 Drosera Network - Simplified Guide

**Contributing to Drosera Testnet Made Easy** 🚀

Created by [@bank_of_btc](https://x.com/bank_of_btc)

---

## 📋 What is Drosera Network?

Drosera Network is a decentralized network where you can deploy "traps" (smart contracts) and run "operators" to respond to them. Think of it as a decentralized automation network!

## 🎯 What You'll Learn

1. ✅ Install all necessary tools
2. ✅ Set up a vulnerable smart contract (trap)
3. ✅ Deploy your trap on Hoodi testnet
4. ✅ Connect operators to respond to your trap
5. ✅ Earn rewards and get Discord roles

## 💻 System Requirements

- **CPU**: 2 cores minimum
- **RAM**: 4 GB minimum  
- **Storage**: 20 GB free space
- **OS**: Ubuntu/Debian (recommended)
- **Budget**: As low as $5/month VPS!

## 🚀 Quick Start (5 Steps)

### Step 1: Server Setup
```bash
# Update your system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install curl ufw git wget jq nano tmux htop unzip -y
```

### Step 2: Install Docker
```bash
# Remove old Docker versions
sudo apt remove docker.io docker-doc docker-compose -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Test Docker
sudo docker run hello-world
```

### Step 3: Install Development Tools
```bash
# Install Drosera CLI
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup

# Install Foundry (for smart contracts)
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

# Install Bun (JavaScript runtime)
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
```

### Step 4: Create Your First Trap
```bash
# Create trap directory
mkdir my-drosera-trap && cd my-drosera-trap

# Initialize Foundry project
forge init --no-commit

# Create your trap contract
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
```

### Step 5: Deploy Your Trap
```bash
# Build your contract
forge build

# Create configuration
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

# Deploy (replace YOUR_PRIVATE_KEY with your actual private key)
DROSERA_PRIVATE_KEY=YOUR_PRIVATE_KEY drosera apply
```

## 🔧 Running Operators

### Single Operator Setup
```bash
# Create operator directory
mkdir ~/drosera-operator && cd ~/drosera-operator

# Create docker-compose file
cat > docker-compose.yaml << 'EOF'
version: '3'
services:
  drosera:
    image: ghcr.io/drosera-network/drosera-operator:latest
    container_name: drosera-node
    network_mode: host
    volumes:
      - drosera_data:/data
    command: node --db-file-path /data/drosera.db --network-p2p-port 31313 --server-port 31314 --eth-rpc-url https://rpc.hoodi.ethpandaops.io --drosera-address 0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D --eth-private-key ${ETH_PRIVATE_KEY} --listen-address 0.0.0.0 --network-external-p2p-address ${VPS_IP} --disable-dnr-confirmation true
    restart: always

volumes:
  drosera_data:
EOF

# Create environment file
cat > .env << 'EOF'
ETH_PRIVATE_KEY=YOUR_OPERATOR_PRIVATE_KEY
VPS_IP=YOUR_SERVER_IP
EOF

# Start operator
docker compose up -d
```

### Dual Operator Setup (Recommended)
```bash
# Use the dual-operator docker-compose.yaml from this repo
cp docker-compose.yaml ~/drosera-operator/
cd ~/drosera-operator

# Edit .env file with both private keys
nano .env

# Start both operators
docker compose up -d
```

## 🎮 Discord Integration

### Get Your Discord Username On-Chain
```bash
cd my-drosera-trap

# Create Discord trap
cat > src/DiscordTrap.sol << 'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract DiscordTrap is ITrap {
    string constant discordName = "YOUR_DISCORD_USERNAME"; // Replace this!

    function collect() external pure returns (bytes memory) {
        return abi.encode(discordName);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        (string memory name) = abi.decode(data[0], (string));
        if (bytes(name).length == 0) {
            return (false, bytes(""));
        }
        return (true, abi.encode(name));
    }
}
EOF

# Update configuration
cat > drosera.toml << 'EOF'
[contract]
path = "out/DiscordTrap.sol/DiscordTrap.json"
address = ""

[response]
contract = "0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608"
function = "respondWithDiscordName(string)"

[network]
eth_chain_id = 560048
drosera_address = "0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D"
eth_rpc_url = "https://rpc.hoodi.ethpandaops.io"
EOF

# Deploy Discord trap
forge build
DROSERA_PRIVATE_KEY=YOUR_PRIVATE_KEY drosera apply
```

## 🔍 Monitoring & Troubleshooting

### Check Operator Status
```bash
# View logs
docker compose logs -f

# Check if operators are running
docker ps

# Restart operators
docker compose restart
```

### Common Issues & Solutions

**White Blocks in Dashboard:**
- Check your RPC URL is working
- Ensure private keys are correct
- Restart operators: `docker compose down && docker compose up -d`

**"Apply config failed" Error:**
- Make sure you have Hoodi ETH in your wallet
- Verify your private key is correct
- Check if trap address is properly set in `drosera.toml`

**Operators Not Connecting:**
- Verify VPS IP is correct in `.env`
- Check firewall settings: `sudo ufw allow 31313:31316`
- Ensure Docker is running: `sudo systemctl status docker`

## 🎯 Useful Commands

```bash
# View all Discord usernames on-chain
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 "getDiscordNamesBatch(uint256,uint256)(string[])" 0 2000 --rpc-url https://rpc.hoodi.ethpandaops.io

# Check if you're a responder
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 "isResponder(address)(bool)" YOUR_ADDRESS --rpc-url https://rpc.hoodi.ethpandaops.io

# Get Hoodi ETH (testnet)
# Visit: https://faucet.hoodi.ethpandaops.io/
```

## 📚 Additional Resources

- **Official Docs**: [Drosera Network](https://drosera.io)
- **Hoodi Explorer**: [https://explorer.hoodi.ethpandaops.io/](https://explorer.hoodi.ethpandaops.io/)
- **Discord**: Join the Drosera community
- **Twitter**: Follow [@bank_of_btc](https://x.com/bank_of_btc) for updates

## 🎉 Success Checklist

- [ ] Server setup complete
- [ ] Docker installed and working
- [ ] Development tools installed
- [ ] First trap deployed
- [ ] Operators running (green blocks)
- [ ] Discord username on-chain
- [ ] Responder status verified

---

**Need Help?** 
- Check the troubleshooting section above
- Join the Discord community
- DM [@bank_of_btc](https://x.com/bank_of_btc) on Twitter

**Made with ❤️ by [@bank_of_btc](https://x.com/bank_of_btc)** 