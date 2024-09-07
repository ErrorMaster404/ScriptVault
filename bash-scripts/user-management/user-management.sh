#!/bin/bash

# Function to add a user
add_user() {
    local username="$1"
    local password="$2"
    local home_dir="$3"

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
        return 1
    fi

    # Create the user
    useradd -m -d "$home_dir" "$username"
    echo "$username:$password" | chpasswd

    if [ $? -eq 0 ]; then
        echo "User '$username' added successfully."
    else
        echo "Failed to add user '$username'."
        return 1
    fi
}

# Function to modify a user's email and/or password
modify_user() {
    local username="$1"
    local new_password="$2"

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo "User '$username' does not exist."
        return 1
    fi

    # Update password
    if [ -n "$new_password" ]; then
        echo "$username:$new_password" | chpasswd
        if [ $? -eq 0 ]; then
            echo "Password for '$username' updated successfully."
        else
            echo "Failed to update password for '$username'."
            return 1
        fi
    else
        echo "No new password provided. Skipping password update."
    fi
}

# Function to delete a user
delete_user() {
    local username="$1"

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo "User '$username' does not exist."
        return 1
    fi

    # Delete the user
    userdel -r "$username"
    if [ $? -eq 0 ]; then
        echo "User '$username' deleted successfully."
    else
        echo "Failed to delete user '$username'."
        return 1
    fi
}

# Function to list all users
list_users() {
    # List all users
    cut -d: -f1 /etc/passwd
}

# Main menu
main_menu() {
    while true; do
        echo
        echo "User Account Management"
        echo "1. Add User"
        echo "2. Modify User"
        echo "3. Delete User"
        echo "4. List Users"
        echo "5. Exit"
        read -rp "Enter your choice (1-5): " choice

        case $choice in
            1)
                read -rp "Enter username: " username
                read -rsp "Enter password: " password
                echo
                read -rp "Enter home directory (leave blank for default): " home_dir
                if [ -z "$home_dir" ]; then
                    home_dir="/home/$username"
                fi
                add_user "$username" "$password" "$home_dir"
                ;;
            2)
                read -rp "Enter username to modify: " username
                read -rsp "Enter new password (leave blank if no change): " new_password
                echo
                modify_user "$username" "$new_password"
                ;;
            3)
                read -rp "Enter username to delete: " username
                delete_user "$username"
                ;;
            4)
                list_users
                ;;
            5)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice. Please enter a number between 1 and 5."
                ;;
        esac
    done
}

# Start the main menu
main_menu
