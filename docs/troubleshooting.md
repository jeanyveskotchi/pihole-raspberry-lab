

#  `docs/troubleshooting.md`

```md
# Troubleshooting – Issues I Encountered and Fixed

During this setup, I encountered several issues related to DNS and NetworkManager.

This section explains what went wrong and how I fixed it.

---

# Issue 1 – Pi-hole Installed but Ads Not Blocked

## Symptom

- Ads still appeared
- `doubleclick.net` resolved to real IPs
- Some DNS queries timed out

Screenshot:

![Not Blocking](../screenshots/piholedoesntwork.png)

---

## Root Cause

When using NetworkManager hotspot mode (`IPv4 method: shared`), NetworkManager automatically runs a helper service called `dnsmasq`.

dnsmasq can provide:
- DHCP (IP assignment)
- DNS forwarding

That meant:

Two services were interacting with DNS:
- NetworkManager’s dnsmasq
- Pi-hole (pihole-FTL)

This created inconsistent DNS behavior.

---

## How I Verified the Problem

I ran:

```bash
sudo ss -tulpn | grep :53
