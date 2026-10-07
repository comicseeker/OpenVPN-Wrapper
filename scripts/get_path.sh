#! /usr/bin/env bash

PR_CONF="$HOME/.config/vpn-gui/config.env"
#0. check dependencies
if [ -f "$PR_CONF" ]; then
    CONNECTIONS_DIR=$(grep "CONF_PATH=" "$PR_CONF" | cut -d "=" -f2)

    if [ ! -d "$CONNECTIONS_DIR" ]; then
        zenity --error --title "No connections available" --text "Connections directory does not exist. Fix it and try later."
        exit 1
	else
		#1. get all .ovpn files
		shopt -s nullglob
		PATH_ARR=("$CONNECTIONS_DIR/*.ovpn")
		shopt -u nullglob

		if [ ${#PATH_ARR[@]} -eq 0 ]; then
    		zenity --error --title "No connections available" --text "Connections directory is empty. Fill it and try again later."
			exit 1
		fi



    fi
else
    zenity --error --title "Config file is missing" --text "Exit and open this app again"
    exit 1
fi




#2. filter by files and non-emptiness
#3. check for "auth", "ca" strings

#exit 1 - all correct
#exit 0 - error