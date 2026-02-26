#!/usr/bin/env bash
set -euo pipefail

echo "=== Interfaces / IPs ==="
hostname -I || true
echo

echo "=== NetworkManager hotspot (PiAP) ==="
nmcli -t -f NAME,TYPE,DEVICE connection show --active || true
echo

echo "=== DNS Port 53 listeners ==="
sudo ss -tulpn | grep ':53' || true
echo

echo "=== NAT (MASQUERADE) ==="
sudo iptables -t nat -L POSTROUTING -n -v | sed -n '1,60p' || true
echo

echo "=== Pi-hole service ==="
sudo systemctl status pihole-FTL --no-pager -l | sed -n '1,20p' || true

## Make scripts executable (run once)
``` bash
chmod +x scripts/*.sh
```
