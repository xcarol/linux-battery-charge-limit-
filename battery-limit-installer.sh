#!/bin/bash
# Install or uninstall battery charge limit service
# Usage: ./battery-limit-installer.sh install [LIMIT]
#        ./battery-limit-installer.sh uninstall

SERVICE_NAME="battery-limit.service"
SCRIPT_NAME="set-battery-limit.sh"
CONFIG_FILE="/etc/battery-limit.conf"

install_service() {
    LIMIT=${1:-80}
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    echo "$LIMIT" | sudo tee "$CONFIG_FILE" > /dev/null

    echo "➡ Copying script to /usr/local/bin..."
    sudo cp "$DIR/$SCRIPT_NAME" /usr/local/bin/
    sudo chmod +x /usr/local/bin/$SCRIPT_NAME

    echo "➡ Copying service to /etc/systemd/system..."
    sudo cp "$DIR/$SERVICE_NAME" /etc/systemd/system/

    echo "➡ Reloading systemd..."
    sudo systemctl daemon-reload

    echo "➡ Activating service..."
    sudo systemctl enable "$SERVICE_NAME"

    echo "➡ Starting service now..."
    sudo systemctl start "$SERVICE_NAME"

    echo "✅ Installation completed. Limit: $LIMIT%"
}

uninstall_service() {
    echo "➡ Stopping service..."
    sudo systemctl stop "$SERVICE_NAME"

    echo "➡ Disabling service..."
    sudo systemctl disable "$SERVICE_NAME"

    echo "➡ Removing files..."
    sudo rm -f /usr/local/bin/$SCRIPT_NAME
    sudo rm -f /etc/systemd/system/$SERVICE_NAME
    sudo rm -f "$CONFIG_FILE"

    echo "➡ Reloading systemd..."
    sudo systemctl daemon-reload

    echo "✅ Uninstallation completed."
}

case "$1" in
    install)
        install_service "$2"
        ;;
    uninstall)
        uninstall_service
        ;;
    *)
        echo "Ús: $0 {install [LIMIT]|uninstall}"
        exit 1
        ;;
esac
