

#  `docs/troubleshooting.md`
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
```
Port 53 is DNS.

When I saw both dnsmasq and pihole-FTL involved, I knew there was a conflict.

Screenshot:

# The Fix

I wanted:

-NetworkManager to keep DHCP

-Pi-hole to own DNS

So I disabled DNS inside NetworkManager’s dnsmasq while keeping DHCP active.

**Step 1 –** Create configuration directory
```bash
sudo mkdir -p /etc/NetworkManager/dnsmasq-shared.d
```
**Step 2 –** Create config file
```bash
sudo nano /etc/NetworkManager/dnsmasq-shared.d/pihole.conf
```
Content:
``` conf
port=0
dhcp-option=option:dns-server,10.42.0.1
```
Explanation:

- port=0 → disables DNS service

- dhcp-option → tells clients to use Pi-hole (10.42.0.1) as DNS

**Step 3 –** Restart NetworkManager
``` bash
sudo systemctl restart NetworkManager
```
**Step 4 –** Reconnect devices

Devices needed to reconnect to receive new DHCP settings.

## Verification After Fix

**1.** Check port 53 again:
```bash
sudo ss -tulpn | grep :53
```
Now only Pi-hole should handle DNS.

**2.** Test blocked domain:
```bash
nslookup doubleclick.net 10.42.0.1
```
Expected:

- 0.0.0.0

- ::

Screenshot:
![Not Blocking](../screenshots/piholeworks.png)

# Issue 2 – Devices Connected but No Internet

If devices connect but can’t browse:

**1.** Check NAT:
```bash
sudo iptables -t nat -L -n -v
```
Ensure MASQUERADE exists for eth0.

If not, restart NetworkManager or reboot the Pi.

# Lessons Learned

- NetworkManager “shared mode” automatically enables dnsmasq.

- Two DNS services can cause unpredictable behavior.

- Always check who owns port 53.

- Use nslookup to test DNS behavior directly.
