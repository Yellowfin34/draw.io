# Draw.io Self-Hosted Installer for Proxmox LXC

This script automatically sets up a self-hosted **Draw.io** (diagrams.net) instance inside a lightweight **Debian 12** LXC container on Proxmox VE.

It installs:
- Docker
- Docker Compose
- Draw.io container (port **8080**)

---

## 🚀 Quick Install

Run this command from your **Proxmox shell**:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Yellowfin34/drawio/main/ct/drawio.sh)"
