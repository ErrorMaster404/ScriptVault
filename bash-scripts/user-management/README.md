# User Account Management Script

This Bash script provides a simple interface for managing user accounts on a Linux system. You can add, modify, delete, and list users using a menu-driven interface.

## Features

1. **Add User**: Create a new user with a specified username, password, and home directory.
2. **Modify User**: Change the password for an existing user.
3. **Delete User**: Remove a user and their home directory from the system.
4. **List Users**: Display all users on the system.

## Usage

1. **Run the script**:
   ```bash
   ./script_name.sh
   ```

2. **Choose an option** from the menu:
   - Add a user
   - Modify a user
   - Delete a user
   - List users
   - Exit the script

## Requirements

- Run the script as a superuser (root) to manage user accounts.

## Notes

- The script checks if a user already exists before adding or modifying.
- User deletions remove the user's home directory as well.
