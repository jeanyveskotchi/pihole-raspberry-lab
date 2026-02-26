#!/usr/bin/env bash
set -euo pipefail

echo "[*] Checking NAT (internet sharing) rules..."
sudo iptables -t nat -L -n -v | sed -n '1,140p'

echo
echo "[*] Expect to see a POSTROUTING MASQUERADE rule going out via eth0."
echo "    If clients have no internet, try: nmcli connection down PiAP && nmcli connection up PiAP"
