# Network Scan Script

`network-scan.py` is a python script that scans available networks and performs a basic ping sweep using `nmap`.

## Prerequisites

Ensure `nmap` and `python3` is installed on your system.

- **Install on Ubuntu/Debian**:  
  `sudo apt-get install nmap python3`

## Usage

1. **Run the script**:
   ```bash
   python3 network-scan.py
   ```

### How It Works

1. **Checks for `nmap`**
2. **Lists available networks**: Select from the displayed networks.
3. **Scans selected network**: Runs a ping sweep using `nmap` and shows active devices.

### Example

```
Available networks:
 1) 192.168.1.0/24
Select a network: 1

Scanning 192.168.1.0/24...

router (192.168.1.1)
laptop (192.168.1.2)
```
