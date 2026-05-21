# SOC Home Lab: Threat Detection & Incident Response

This project documents the setup and implementation of a Security Operations Center (SOC) home lab designed to simulate real-world attacks and develop detection capabilities. The goal is to gain hands-on experience with industry-standard tools like Wazuh, Sysmon, and the ELK stack.

## Architecture Overview

The lab environment consists of:
- **Wazuh (Manager):** Centralized log collection, analysis, and alerting.
- **Wazuh (Agent):** Installed on endpoints (Windows/Linux) to monitor activities.
- **Sysmon:** Advanced host-based telemetry on Windows endpoints.
- **ELK Stack:** Used for log visualization and dashboarding.
- **Kali Linux:** For simulating various attack scenarios.

## Project Goals

1.  **Telemetry Collection:** Configure endpoints to generate high-fidelity logs.
2.  **Attack Simulation:** Execute common adversary techniques (TTPs) based on the MITRE ATT&CK framework.
3.  **Custom Detection Rules:** Develop and fine-tune rules in Wazuh to detect simulated threats.
4.  **Incident Response:** Practice the end-to-end process of detecting, investigating, and documenting security incidents.

## Lab Setup

### 1. Endpoint Monitoring (Windows)
- Install **Sysmon** using a customized configuration file to capture process creation, network connections, and registry changes.
- Install the **Wazuh Agent** and configure it to forward Sysmon logs to the Wazuh Manager.

### 2. Endpoint Monitoring (Linux)
- Configure **Auditd** for monitoring system calls and file integrity.
- Deploy the **Wazuh Agent** to collect system logs and audit data.

### 3. Attack Simulations
The `scripts/` directory contains automation for various attack scenarios:
- **SSH Brute Force:** Simulates unauthorized access attempts.
- **Persistence via Crontab:** Demonstrates how attackers maintain access on Linux systems.

## Detections

Custom detection rules are located in the `detections/` folder. These rules map to specific MITRE ATT&CK techniques, such as:
- **T1110 (Brute Force)**
- **T1053.003 (Scheduled Task/Job: Cron)**

## Incident Walkthroughs

Detailed analysis of simulated incidents can be found in the `docs/` folder. Each walkthrough covers:
- Initial Alert
- Investigation Steps
- Correlation with Logs
- Remediation Recommendations
