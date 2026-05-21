# Incident Investigation Walkthrough: SSH Brute Force

**Incident Date:** 2023-10-27
**Analyst:** SOC Analyst
**Severity:** Medium/High
**Status:** Resolved

## 1. Initial Alert
The SOC team received a high-priority alert (Rule ID: 100001) indicating multiple failed SSH login attempts originating from a single source IP address: `192.168.1.50`.

## 2. Investigation Steps

### A. Telemetry Review
- **Source IP:** `192.168.1.50`
- **Destination Host:** `ubuntu-server-01`
- **Usernames Targeted:** `admin`, `root`, `user`, `test`, `guest`, `support`
- **Attempt Frequency:** ~1 attempt per second

### B. Correlation
Checked the Wazuh dashboard for other activity from the same source IP. No other successful logins were detected within the last 24 hours.

### C. Log Analysis
Examine the `/var/log/auth.log` on the target server:
```text
Oct 27 10:00:01 ubuntu-server-01 sshd[1234]: Failed password for root from 192.168.1.50 port 56789 ssh2
Oct 27 10:00:02 ubuntu-server-01 sshd[1235]: Failed password for admin from 192.168.1.50 port 56790 ssh2
...
```

## 3. Findings
The activity matches the pattern of an automated brute force attack. All attempts were unsuccessful, meaning no compromise occurred during this window.

## 4. Remediation & Recommendations
- **Immediate Action:** Blocked the source IP `192.168.1.50` at the network firewall.
- **Long-term Improvements:**
  - Disable password-based SSH authentication; use SSH keys instead.
  - Implement Fail2Ban to automatically block IPs after 3-5 failed attempts.
  - Restrict SSH access to known VPN ranges.

## 5. Conclusion
This incident demonstrates the effectiveness of custom Wazuh rules in detecting early-stage reconnaissance and brute force attempts. The detection allowed for proactive blocking before a potential compromise.
