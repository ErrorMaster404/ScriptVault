# ClamAV Scanning Bash Script

This Bash script is designed to automate the scanning of files using ClamAV, a popular open-source antivirus software. It performs a recursive scan on a specified directory and sends notifications in case of virus detection or any problems encountered during the scanning process.

## Compatibility

This script was developed and tested for desktop environments and has been verified to work on:

- Ubuntu with GNOME desktop
- Debian with KDE desktop

## Prerequisites

Before using this script, ensure the following:

1. **ClamAV** & **libnotify-bin** is installed on your system.
2. The user executing the script has necessary permissions to access the directories and files to be scanned.

## Usage

1. Make sure ClamAV is installed on your system.
2. Save this script to a file, for example, `clamav_script.sh`.
3. Open a terminal and navigate to the directory containing the script.
4. Make the script executable: `chmod +x clamav_script.sh`
5. Run the script: `./clamav_script.sh`

Optional:

6. Set a cronjob to execute the script daily

## Script Overview

The script follows these main steps:

1. Set variables, including log directories and file paths.
2. Run ClamAV scan on the specified directory.
3. Check the scan result and take appropriate actions.
4. Send notifications if viruses are found or if there are problems during scanning.

## Configuration

You can modify the following variables in the script:

- `LOG_DIR`: The directory where log files will be stored.
- `SCAN_LOGS`: The path to the log file for all scan logs.

## Notifications

The script uses the `notify-send` command to send notifications. Make sure your system supports this command. Notifications are sent in two cases:

1. **Virus Found:** If a virus is detected during the scan, a critical notification is sent with details about the virus found.

2. **Problems Running ClamAV:** If there are issues while running ClamAV, a critical notification is sent with a message to check the logs for more information.

## Note

- The script is designed to be run as `root` user.
- The script uses the `ionice` command to set low I/O priority and `nice` command to set low CPU priority for the scan, minimizing its impact on system performance.

## Log Rotation

To manage the size and retention of the `scan_logs.log` file, you can use the `logrotate` utility. Create a file named `/etc/logrotate.d/clamav_scan_logs` with the following content:
```bash
/var/log/clamav/scan_logs.log {
        monthly
        rotate 3
        compress
        delaycompress
        missingok
        notifempty
        create 644 root root
}
```

This configuration will rotate the `scan_logs.log` file on a monthly basis, keeping the last three rotated log files. The logs will be compressed and kept in the same directory.

## Disclaimer

This script is provided as-is and without any warranty. Use it at your own risk. Make sure to review and understand the script before running it, and test it in a controlled environment before deploying it in a production setting.
