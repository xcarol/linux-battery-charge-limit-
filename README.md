# Battery Charge Limit Service

A simple script and systemd service to set a custom battery charge limit on Linux systems (tested on Kubuntu).  
The service applies your preferred limit automatically at boot.

## Installation

```bash
# Install with default limit (80%)
./battery-limit-installer.sh install

# Install with custom limit (e.g. 85%)
./battery-limit-installer.sh install 85
```

## Uninstallation

```bash
./battery-limit-installer.sh uninstall
```

## Files

- **set-battery-limit.sh** – Script that sets the charge limit.
- **battery-limit.service** – systemd service to apply the limit at startup.
- **battery-limit-installer.sh** – Installer/uninstaller script.
- **/etc/battery-limit.conf** – Stores your configured charge limit.

## Requirements

- Root privileges (sudo).
- Kernel and hardware support for `/sys/class/power_supply/*/charge_control_end_threshold`.

## Notes

- The limit will be applied automatically on each boot once the service is enabled.
- If your hardware does not support `charge_control_end_threshold`, this script will not work.
