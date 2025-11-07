#!/usr/bin/env bash
#                                 _            _        _
# __   ___ __  _ __     __ _  ___| |_      ___| |_ __ _| |_ _   _ ___
# \ \ / / '_ \| '_ \   / _` |/ _ \ __|____/ __| __/ _` | __| | | / __|
#  \ V /| |_) | | | | | (_| |  __/ ||_____\__ \ || (_| | |_| |_| \__ \
#   \_/ | .__/|_| |_|  \__, |\___|\__|    |___/\__\__,_|\__|\__,_|___/
#       |_|            |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

INTERFACE=$(ip link show type wireguard up | awk -F': ' '{print $2}' | cut -d'@' -f1)

if [[ $INTERFACE == "" ]]; then
    echo "{\"text\": \"\", \"alt\": \"off\"}"
else
	DISPLAY=""
	if [[ $INTERFACE == *"Raspberrypi-VPN"* ]]; then
		DISPLAY+="Raspberrypi VPN"
	fi
	if [[ $INTERFACE == *"wg0-mullvad"* ]]; then
		if [[ $DISPLAY != "" ]]; then
			DISPLAY+=" | "
		fi
		PLACE=$(mullvad status | grep "Visible location:" | sed 's/.*Visible location:\s*//' | cut -d'.' -f1)
		DISPLAY+=$PLACE
	fi
    echo "{\"text\": \" 󰒃  \", \"tooltip\": \"$DISPLAY\", \"alt\": \"connected\"}"
fi
