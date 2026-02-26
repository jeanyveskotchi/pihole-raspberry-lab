# Architecture – My Pi-hole Raspberry Pi 5 Lab

In this project, I built an isolated Wi-Fi network on my Raspberry Pi 5 and used Pi-hole as a DNS filtering layer for all connected devices.

The goal was:
- Create my own hotspot (PiTestNet)
- Route traffic to the Internet through Ethernet
- Force all devices to use Pi-hole as DNS
- Understand and fix DNS conflicts with NetworkManager

---

## My Network Layout

My Raspberry Pi has two interfaces:

- `eth0` → Connected to my apartment router (Internet access)
- `wlan0` → Hotspot network (PiTestNet)

Example IP addresses:

- `eth0`: 192.168.0.64
- `wlan0`: 10.42.0.1

All my IoT devices and phone connect to `PiTestNet`.

Architecture:
[Devices]
↓
(wlan0) 10.42.0.1 ← Hotspot
↓
Pi-hole (DNS filtering)
↓
(eth0) 192.168.0.64
↓
Internet

---

## What Pi-hole Does in My Lab

Pi-hole works at the DNS level.

Normally:
device → DNS server → returns IP → ad loads

With Pi-hole:
device → Pi-hole → if domain is blocked → returns 0.0.0.0 → ad fails

When I tested blocking:

```bash
nslookup doubleclick.net 10.42.0.1
```
It returned:

- 0.0.0.0

- ::

Screenshot proof:

![Not Blocking](../screenshots/piholeworks.png)

That means DNS-level blocking is active.

## Why Port 53 Was Critical

DNS uses port 53.

I verified who was listening on port 53 with:

``` bash
sudo ss -tulpn | grep :53
 ```

At first, I noticed both:

- dnsmasq

- pihole-FTL

were associated with port 53.

Screenshot:

![Not Blocking](../screenshots/bothport53)

That led to inconsistent behavior.

After fixing it, only Pi-hole handled DNS:

 ![Not Blocking](../screenshots/onlypiholetoport53.png)
 
## NAT (Internet Sharing)

To allow hotspot clients to reach the Internet through Ethernet, NAT must be enabled.

I verified NAT using:
``` bash
sudo iptables -t nat -L -n -v
```
The important rule is:
``` bash
MASQUERADE  →  eth0
```
This allows devices on wlan0 to access the Internet through eth0.

## Dashboard Validation

After everything was configured properly:

- Total queries increased

- Blocked queries increased

- Multiple clients appeared

Screenshot:

![Not Blocking](../screenshots/dashboards.png)

That confirmed:
- DNS routing works
- Filtering works
- Clients are correctly using Pi-hole
