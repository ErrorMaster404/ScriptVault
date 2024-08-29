#!/bin/bash

# Function to check if a command is available
check_command() {
    if ! command -v nmap >/dev/null 2>&1; then
        echo "nmap is not installed. Please install it and try again."
        exit 1
    fi
}

# Function to display available networks
display_networks() {
    local count=1
    echo "Available networks:"
    echo " 0) Quit"
    for net in $network_list; do
        echo " $count) $net"
        count=$((count + 1))
    done
    echo
}

# Check if nmap is installed
check_command

# Find available networks
network_list=$(ip -o -4 addr list | awk '{print $4}' | grep -vE '^fe80|127.0|::|fd0c' | sort -u)

if [ -z "$network_list" ]; then
    echo "No valid network interfaces found."
    while true; do
        read -p "Retry? (y/n): " retry
        if [[ "$retry" =~ ^[Yy]$ ]]; then
            exec "$0"
        elif [[ "$retry" =~ ^[Nn]$ ]]; then
            echo "Exiting."
            exit 1
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
fi

# Display networks and prompt user for selection
display_networks

# Select network to scan
while true; do
    read -p "Select a network to scan (enter the number): " selected_network

    # Validate input is a positive integer and within the list
    if [[ "$selected_network" =~ ^[0-9]+$ ]] && [ "$selected_network" -ge 0 ] && [ "$selected_network" -le "$(echo "$network_list" | wc -w)" ] ; then
        break
    else
        echo "Invalid selection. Please enter a valid number from the list."
    fi
done

# Handle quit option
if [ "$selected_network" -eq 0 ]; then
    echo "Exiting."
    exit 0
fi

# Determine the selected network
count=1
network=""
for net in $network_list; do
    if [ "$count" -eq "$selected_network" ]; then
        network="$net"
        break
    fi
    count=$((count + 1))
done

if [ -z "$network" ]; then
    echo "Error: Selected network not found. Exiting."
    exit 1
fi

echo "Selected network: $network"

# Perform network scan
echo -e "Scanning $network. This may take a moment...\n"
network_s=$(echo "$network" | awk -F "." '{print $1"."$2}')
if ! nmap_output=$(nmap -sP "$network" 2>/dev/null); then
    echo "Error: nmap failed to execute."
    exit 1
fi

echo "$nmap_output" | grep "$network_s" | awk '{print $5, $6}'
echo "Scan complete."
