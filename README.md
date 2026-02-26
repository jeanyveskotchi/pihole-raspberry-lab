# Pi-hole Raspberry Pi 5 Isolated Lab (NetworkManager Hotspot + Pi-hole DNS)

This repo documents how to build an **isolated home-lab Wi-Fi network (PiTestNet)** on a Raspberry Pi 5 and run **Pi-hole** as the DNS server to block ads/trackers for all connected devices.

It also documents a common issue: when using **NetworkManager Hotspot (IPv4 method: shared)**, **NetworkManager spawns dnsmasq**, which can conflict with Pi-hole DNS (port 53). This guide shows how to fix it cleanly.

---

## What you’ll build

**Goal:** IoT devices connect to your Pi hotspot network and use Pi-hole for DNS filtering.
