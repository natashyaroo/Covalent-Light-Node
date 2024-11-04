## Hardware Requirements

### Minimum Requirements
- **CPU:** 1+ cores
- **RAM:** 1.5 GB
- **Storage:** 1.5 GB
- **Internet:** Stable connection

### Recommended Specifications
- **CPU:** Multi-core for enhanced performance
- **RAM:** 4 GB
- **Storage:** 10 GB
- **Internet:** Stable connection

## Quick Installation

You can quickly set up your EWM Light Client using our automated installation script:

```bash
# Download the setup script
wget https://raw.githubusercontent.com/natashyaroo/Covalent-Light-Node/refs/heads/main/setup.sh

# Make it executable
chmod +x setup.sh

# Run the script with sudo
sudo ./setup.sh
```

The script will automatically:
- Install all required dependencies
- Set up the GO environment
- Install IPFS Kubo client
- Clone and build the EWM-DAS repository
- Configure and start your light client

## Prerequisites

### 1. Join the Exclusive Waitlist
To participate in running an EWM Light Client, you must join the exclusive waitlist. [Fill out this form](https://docs.google.com/forms/d/e/1FAIpQLSfP7qf82g5BgmnKRaaBFj9py3OY8-5GhgoHtGW9SXHiG5bJ1w/viewform) with your name and email.

### 2. Whitelist Verification
**Note**: Only verified participants from the official waitlist will be eligible for testnet/mainnet access and future rewards.

After receiving whitelist instructions via email, you will need to submit two addresses:

1. **Light Client Owner Address (Mainnet Wallet Address)**
   - This address will receive rewards during the testnet phase
   - Will be used to get whitelisted for the mainnet launch

2. **Burner Address**
   - This address should **NOT** hold any funds
   - Will be used by the light client to sign completed work
   - You can generate a burner address using these tools:
     - [Visual-Key](https://visualkey.link/)
     - [Vanity-ETH](https://vanity-eth.tk/)
     - [Eth-Vanity](https://github.com/johguse/profanity)

**Important**: Remember to:
- Save both the private key and public address

## Monitoring Your Node

After installation, you can monitor your node using these Docker commands:

```bash
# Check if container is running
docker ps

# View container logs
docker logs light-client

# Check container status
docker stats light-client
```
