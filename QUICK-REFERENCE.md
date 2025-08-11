# ⚡ Drosera Network - Quick Reference

**Essential commands and info at your fingertips** 🚀

Created by [@bank_of_btc](https://x.com/bank_of_btc)

---

## 🚀 One-Click Setup

```bash
# Download and run setup script
curl -fsSL https://raw.githubusercontent.com/lemo1bot/drosera-simplified/main/setup.sh | bash
```

## 📋 Essential Commands

### System Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh

# Install tools
curl -L https://app.drosera.io/install | bash  # Drosera CLI
curl -L https://foundry.paradigm.xyz | bash    # Foundry
curl -fsSL https://bun.sh/install | bash       # Bun
```

### Trap Management
```bash
# Build trap
forge build

# Deploy trap
DROSERA_PRIVATE_KEY=YOUR_KEY drosera apply

# Test trap
drosera dryrun

# View trap config
cat drosera.toml
```

### Operator Management
```bash
# Start operators
docker compose up -d

# Stop operators
docker compose down

# Restart operators
docker compose restart

# View logs
docker compose logs -f

# Check status
docker ps
```

### Network Commands
```bash
# Check Hoodi ETH balance
cast balance YOUR_ADDRESS --rpc-url https://rpc.hoodi.ethpandaops.io

# Check if you're a responder
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 "isResponder(address)(bool)" YOUR_ADDRESS --rpc-url https://rpc.hoodi.ethpandaops.io

# View Discord usernames
cast call 0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608 "getDiscordNamesBatch(uint256,uint256)(string[])" 0 2000 --rpc-url https://rpc.hoodi.ethpandaops.io
```

## 🔧 Configuration Files

### Environment Variables (.env)
```bash
VPS_IP=YOUR_VPS_IP
RPC_URL_1=https://rpc.hoodi.ethpandaops.io
RPC_URL_2=https://rpc.hoodi.ethpandaops.io
ETH_PRIVATE_KEY=YOUR_FIRST_KEY
ETH_PRIVATE_KEY2=YOUR_SECOND_KEY
```

### Trap Configuration (drosera.toml)
```toml
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
```

## 🌐 Important Addresses

| Network | Address | Description |
|---------|---------|-------------|
| **Hoodi Chain ID** | `560048` | Testnet chain ID |
| **Drosera Contract** | `0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D` | Main Drosera address |
| **Response Contract** | `0x25E2CeF36020A736CF8a4D2cAdD2EBE3940F4608` | Response contract |
| **RPC URL** | `https://rpc.hoodi.ethpandaops.io` | Public RPC endpoint |

## 🔍 Troubleshooting Commands

```bash
# Check Docker status
sudo systemctl status docker

# Check firewall
sudo ufw status

# Allow ports
sudo ufw allow 31313:31316

# Check your IP
curl ifconfig.me

# Test RPC
curl -X POST https://rpc.hoodi.ethpandaops.io -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

## 📱 Useful Links

- **Dashboard**: https://app.drosera.io
- **Explorer**: https://explorer.hoodi.ethpandaops.io/
- **Faucet**: https://faucet.hoodi.ethpandaops.io/
- **Twitter**: [@bank_of_btc](https://x.com/bank_of_btc)

## 🎯 Success Indicators

- ✅ Green blocks in dashboard
- ✅ `docker ps` shows running containers
- ✅ `isResponder` returns `true`
- ✅ No error messages in logs

## 🚨 Emergency Commands

```bash
# Reset everything
docker compose down -v
docker system prune -a
rm -rf ~/drosera-project

# Quick restart
docker compose restart

# Check all logs
docker compose logs --tail=100
```

---

**Need help?** Check `TROUBLESHOOTING.md` or DM [@bank_of_btc](https://x.com/bank_of_btc)

**Made with ❤️ by [@bank_of_btc](https://x.com/bank_of_btc)** 