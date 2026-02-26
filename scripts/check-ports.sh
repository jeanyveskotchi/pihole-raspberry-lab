#!/usr/bin/env bash
set -euo pipefail

echo "[*] Who is listening on DNS port 53?"
sudo ss -tulpn | grep ':53' || echo "[!] Nothing is listening on :53 (unexpected)"
