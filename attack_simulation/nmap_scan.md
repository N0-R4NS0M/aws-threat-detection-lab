# Port Scan Simulation with Nmap

This document outlines how to simulate a port scanning attack from a second EC2 instance in your lab.

## 1. Launch a Second EC2 (Attacker)

- Launch an EC2 instance in the same VPC
- Use the same key pair so you can SSH in
- Install nmap:
```bash
sudo yum install -y nmap
```

## 2. Run Port Scan on Target Instance

From the attacker instance:
```bash
nmap -sS <TARGET_INSTANCE_PRIVATE_IP>
```

## 3. Observe GuardDuty

- Go to AWS Console → GuardDuty → Findings
- Look for Recon:EC2/Portscan or similar
- This will trigger your Lambda auto-remediation if set up
