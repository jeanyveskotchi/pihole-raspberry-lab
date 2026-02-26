# Contributing to Pi-hole Raspberry Lab

Thank you for your interest in improving this project.

This repository documents my personal lab setup using:

- Raspberry Pi 5
- NetworkManager hotspot (IPv4 shared mode)
- Pi-hole DNS filtering
- NAT via iptables

If you have improvements, fixes, or enhancements, contributions are welcome.

---

## How to Contribute

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a Pull Request

Please keep contributions:

- Clear and documented
- Tested (if modifying scripts)
- Consistent with the current folder structure

---

## Suggested Contributions

Examples of useful improvements:

- Additional troubleshooting scenarios
- Support for different Raspberry Pi OS versions
- Improvements to DNS conflict handling
- IPv6 enhancements
- Better logging scripts
- Performance optimizations
- Security hardening suggestions

---

## Reporting Issues

If something does not work:

Please include:

- Your Raspberry Pi model
- OS version
- Output of:
  ```bash
  sudo ss -tulpn | grep :53
  hostname -I
  sudo iptables -t nat -L -n -v
  ```
