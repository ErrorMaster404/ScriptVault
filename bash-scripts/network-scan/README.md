# Network Scan Script

`network-scan.sh` is a Bash script that scans available networks and performs a basic ping sweep using `nmap`.

## Prerequisites

Ensure `nmap` is installed on your system.

- **Install on Ubuntu/Debian**:  
  `sudo apt-get install nmap`

## Usage

1. **Make the script executable**:
   ```bash
   chmod +x network-scan.sh
   ```

2. **Run the script**:
   ```bash
   ./network-scan.sh
   ```

### How It Works

1. **Checks for `nmap`**: If not installed, prompts you to install it.
2. **Lists available networks**: Select from the displayed networks.
3. **Scans selected network**: Runs a ping sweep using `nmap` and shows active devices.

### Example

```
Available networks:
 1) 192.168.1.0/24
Select a network: 1

Scanning 192.168.1.0/24...

192.168.1.1 router
192.168.1.2 laptop
```
