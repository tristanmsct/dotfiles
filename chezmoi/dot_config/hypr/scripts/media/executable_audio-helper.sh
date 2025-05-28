#!/bin/bash
#                  _ _             _          _
#   __ _ _   _  __| (_) ___       | |__   ___| |_ __   ___ _ __
#  / _` | | | |/ _` | |/ _ \ _____| '_ \ / _ \ | '_ \ / _ \ '__|
# | (_| | |_| | (_| | | (_) |_____| | | |  __/ | |_) |  __/ |
#  \__,_|\__,_|\__,_|_|\___/      |_| |_|\___|_| .__/ \___|_|
#                                              |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# Simple utility for audio devices.
#
# This scripts solves the issue of audio devices connected to two devices, and one
# does not want to release the connection even when sound stop playing.
# If no device is connected then the script tries to connect one.
#
# To add a device, get its name, mac and info with `pactl list cards`.
# -----------------------------------------------------------------------------------------------------------------------------------------

# MAC Adresses are hard coded, something as to be hardcoded anyway, might as well be the MAC Adress, it is the most stable element.
BOSE_HEADSET_MAC="C8_7B_23_47_4B_DB"
PIXEL_BUDS_MAC="B8_7B_D4_10_6B_B3"


# If no audio device is connected then tries to connect one.
if ! pactl list cards | grep -q "$BOSE_HEADSET_MAC" && ! pactl list cards | grep -q "$PIXEL_BUDS_MAC"; then
    BLUETOOTH_MAC=$(echo "$BOSE_HEADSET_MAC" | tr '_' ':')
    bluetoothctl connect "$BLUETOOTH_MAC"
    sleep 1
    if ! pactl list cards | grep -q "$BOSE_HEADSET_MAC"; then
        BLUETOOTH_MAC=$(echo "$PIXEL_BUDS_MAC" | tr '_' ':')
        bluetoothctl connect "$BLUETOOTH_MAC"
    fi

# If one or more audio device is connected, reset audio profile.
else
    if pactl list cards | grep -q "$BOSE_HEADSET_MAC"; then
        # For some reason, the right profile just disapear sometimes so reconnect the whole device is simpler.
        # pactl set-card-profile bluez_card."$BOSE_HEADSET_MAC" "a2dp-sink-sbc"
        # sleep 1
        # pactl set-card-profile bluez_card."$BOSE_HEADSET_MAC" "a2dp-sink-sbc_xq"

        BLUETOOTH_MAC=$(echo "$BOSE_HEADSET_MAC" | tr '_' ':')
        bluetoothctl disconnect "$BLUETOOTH_MAC"
        sleep 1
        bluetoothctl connect "$BLUETOOTH_MAC"
    fi

    if pactl list cards | grep -q "$PIXEL_BUDS_MAC"; then
        pactl set-card-profile bluez_card."$PIXEL_BUDS_MAC" "a2dp-sink-sbc"
        sleep 1
        pactl set-card-profile bluez_card."$PIXEL_BUDS_MAC" "a2dp-sink-opus_g"
    fi
fi
