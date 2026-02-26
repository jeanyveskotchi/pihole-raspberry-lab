# `docs/glossary.md`
# Glossary – Concepts I Learned During This Project

## DNS (Domain Name System)

Converts domain names into IP addresses.

Example: google.com → 142.x.x.x

Pi-hole filters DNS requests.

---

## DHCP (Dynamic Host Configuration Protocol)

Automatically assigns IP addresses to devices.

Example:
-10.42.0.109
-10.42.0.99

In my lab, NetworkManager provides DHCP.

---

## NAT (Network Address Translation)

Allows multiple devices to share one Internet connection.

In my setup:
wlan0 clients → NAT → eth0 → Internet

---

## Port 53

Standard DNS port.

Only one main DNS service should control it.

I verified ownership with:

```bash
sudo ss -tulpn | grep :53
```
## dnsmasq

A lightweight service that can:

-Provide DHCP

-Provide DNS forwarding

NetworkManager uses it internally in hotspot mode.

## Pi-hole (FTL)

Pi-hole’s DNS engine is called pihole-FTL.

It:

-Receives DNS queries

-Checks blocklists

-Returns 0.0.0.0 for blocked domains

-Forwards allowed queries upstream

