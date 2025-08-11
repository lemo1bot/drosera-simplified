# 🔧 Drosera Network Troubleshooting Guide

**Quick fixes for common issues** 🛠️

Created by [@bank_of_btc](https://x.com/bank_of_btc)

---

## 🚨 Common Issues & Solutions

### 1. White Blocks in Dashboard

**Problem**: Your operators show white blocks instead of green blocks in the dashboard.

**Solutions**:
```bash
# Check if operators are running
docker ps

# View operator logs
docker compose logs -f

# Restart operators
docker compose down -v
docker compose up -d

# Check your RPC URL
curl -X POST https://rpc.hoodi.ethpandaops.io \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

**If still not working**:
- Verify your private keys are correct (without 0x prefix)
- Check if your VPS IP is correct: `curl ifconfig.me`
- Ensure Docker is running: `sudo systemctl status docker`

### 2. "Apply config failed" Error

**Problem**: Getting "Apply config failed" when deploying traps.

**Solutions**:
```bash
# Check if you have Hoodi ETH
cast balance YOUR_ADDRESS --rpc-url https://rpc.hoodi.ethpandaops.io

# Get testnet ETH
# Visit: https://faucet.hoodi.ethpandaops.io/

# Verify your private key format
# Should be 64 characters, no 0x prefix
echo "YOUR_PRIVATE_KEY" | wc -c
```

**Common causes**:
- No Hoodi ETH in wallet
- Incorrect private key format
- Network connectivity issues

### 3. Operators Not Connecting

**Problem**: Operators can't connect to the network.

**Solutions**:
```bash
# Check firewall settings
sudo ufw status

# Allow required ports
sudo ufw allow 31313:31316

# Check if ports are in use
netstat -tulpn | grep :3131

# Restart Docker
sudo systemctl restart docker
```

### 4. Docker Permission Issues

**Problem**: "Permission denied" when running Docker commands.

**Solutions**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or run:
newgrp docker

# Or use sudo temporarily
sudo docker compose up -d
```

### 5. Foundry/Forge Not Found

**Problem**: `forge: command not found`

**Solutions**:
```bash
# Reload shell environment
source ~/.bashrc

# Reinstall Foundry
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup
```

### 6. Drosera CLI Issues

**Problem**: `drosera: command not found`

**Solutions**:
```bash
# Reload shell environment
source ~/.bashrc

# Reinstall Drosera CLI
curl -L https://app.drosera.io/install | bash
source ~/.bashrc
droseraup
```

### 7. Contract Build Errors

**Problem**: `forge build` fails

**Solutions**:
```bash
# Install dependencies
forge install drosera-contracts

# Clean and rebuild
forge clean
forge build

# Check Solidity version
forge build --force
```

### 8. RPC Connection Issues

**Problem**: Can't connect to RPC endpoints

**Solutions**:
```bash
# Test public RPC
curl -X POST https://rpc.hoodi.ethpandaops.io \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'

# Get your own RPC (recommended)
# Alchemy: https://www.alchemy.com/
# QuickNode: https://www.quicknode.com/
```

## 🔍 Diagnostic Commands

### Check System Status
```bash
# Check Docker status
sudo systemctl status docker

# Check disk space
df -h

# Check memory usage
free -h

# Check CPU usage
htop
```

### Check Network Status
```bash
# Check your IP
curl ifconfig.me

# Test internet connectivity
ping -c 3 google.com

# Check DNS
nslookup rpc.hoodi.ethpandaops.io
```

### Check Operator Status
```bash
# View all containers
docker ps -a

# View operator logs
docker compose logs drosera1
docker compose logs drosera2

# Check container resources
docker stats
```

## 🛠️ Reset Everything

If you need to start fresh:

```bash
# Stop and remove all containers
docker compose down -v

# Remove all Docker images
docker system prune -a

# Remove project directories
rm -rf ~/drosera-project

# Reinstall everything
cd ~/drosera-simplified
./setup.sh
```

## 📞 Getting Help

### Before Asking for Help:
1. ✅ Check this troubleshooting guide
2. ✅ Run diagnostic commands above
3. ✅ Check operator logs: `docker compose logs -f`
4. ✅ Verify your configuration files

### When Asking for Help:
- Include error messages
- Share your system info: `uname -a`
- Share Docker version: `docker --version`
- Share operator logs (without private keys)

### Community Resources:
- **Discord**: Join the Drosera community
- **Twitter**: DM [@bank_of_btc](https://x.com/bank_of_btc)
- **GitHub**: Open an issue in this repo

## 🎯 Quick Fix Checklist

- [ ] Operators running: `docker ps`
- [ ] Green blocks in dashboard
- [ ] RPC URL working
- [ ] Private keys correct (no 0x prefix)
- [ ] VPS IP correct
- [ ] Firewall ports open (31313-31316)
- [ ] Docker permissions fixed
- [ ] Hoodi ETH in wallet

---

**Need more help?** 
- Check the main README.md
- Join the Discord community
- Follow [@bank_of_btc](https://x.com/bank_of_btc) for updates

**Made with ❤️ by [@bank_of_btc](https://x.com/bank_of_btc)** 