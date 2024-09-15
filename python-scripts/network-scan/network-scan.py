import subprocess
import shutil
import sys

def check_command():
    """Check if nmap is installed."""
    if not shutil.which("nmap"):
        print("nmap is not installed. Please install it and try again.")
        sys.exit(1)

def find_networks():
    """Find available network interfaces."""
    try:
        result = subprocess.run(
            ["ip", "-o", "-4", "addr", "list"],
            capture_output=True, text=True, check=True
        )
        network_list = set()
        for line in result.stdout.splitlines():
            parts = line.split()
            network = parts[3]
            if not network.startswith(("fe80", "127.0", "::", "fd0c")):
                network_list.add(network)
        return sorted(network_list)
    except subprocess.CalledProcessError as e:
        print(f"Error finding networks: {e}")
        return []

def display_networks(network_list):
    """Display available networks."""
    print("Available networks:")
    print(" 0) Quit")
    for idx, net in enumerate(network_list, start=1):
        print(f" {idx}) {net}")
    print()

def main():
    """Main program."""
    check_command()
    
    while True:
        network_list = find_networks()
        if not network_list:
            print("No valid network interfaces found.")
            retry = input("Retry? (y/n): ").strip().lower()
            if retry == "y":
                continue
            elif retry == "n":
                print("Exiting.")
                sys.exit(1)
            else:
                print("Invalid input. Please enter 'y' or 'n'.")
                continue

        display_networks(network_list)

        try:
            selected_network = int(input("Select a network to scan (enter the number): ").strip())
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            continue

        if selected_network == 0:
            print("Exiting.")
            sys.exit(0)

        if 1 <= selected_network <= len(network_list):
            network = network_list[selected_network - 1]
            print(f"Selected network: {network}")
            break
        else:
            print("Invalid selection. Please select a valid number from the list.")

    print(f"Scanning {network}. This may take a moment...\n")

    network_s = ".".join(network.split(".")[:2])
    try:
        result = subprocess.run(
            ["nmap", "-sP", network],
            capture_output=True, text=True, check=True
        )
        nmap_output = result.stdout
    except subprocess.CalledProcessError:
        print("Error: nmap failed to execute.")
        sys.exit(1)

    for line in nmap_output.splitlines():
        if network_s in line:
            parts = line.split()
            print(f"{parts[-2]} {parts[-1]}")
    
    print("Scan complete.")

if __name__ == "__main__":
    main()
