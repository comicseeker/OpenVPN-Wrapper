#! /usr/bin/env bash

CONF_PATH="$HOME/.config/vpn-gui/config.env"
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ ! -f "$CONF_PATH" ]; then
	mkdir -p "$(dirname "$CONF_PATH")"

	cat << EOF > "$CONF_PATH"
# Params
# Path for folder with logs
LOG_PATH=$SCRIPT_DIR/logs

# Path for folder with configs (can be changed in gui)
CONF_PATH=$SCRIPT_DIR/configs

# For connections with user authentication
AUTH_IS_NEEDED=true

# If more than 1 way of authentication is used
# ALSO divides all connections by folders where .ovpn is located
MULTIPROFILE=true
EOF

if [ ! -d "$SCRIPT_DIR/scripts" ]; then
	mkdir -p "$SCRIPT_DIR/scripts"
fi

if [ -f "$SCRIPT_DIR/scripts/ask_pass.sh" ]; then
	chmod +x "$SCRIPT_DIR/scripts/ask_pass.sh"
else
	zenity --error --title "Critical error" --text "ask_pass.sh script is missing. Reinstall app and try again"
	exit 1

fi
if [ -f "$SCRIPT_DIR/scripts/get_path.sh" ]; then
	chmod +x "$SCRIPT_DIR/scripts/get_path.sh"
else
	zenity --error --title "Critical error" --text "get_path.sh script is missing. Reinstall app and try again"
	exit 1
fi
if [ -f "$SCRIPT_DIR/scripts/main.sh" ]; then
	chmod +x "$SCRIPT_DIR/scripts/main.sh"
else
	zenity --error --title "Critical error" --text "main.sh script is missing. Reinstall app and try again"
	exit 1
fi

fi

exec "$SCRIPT_DIR/scripts/get_path.sh"

