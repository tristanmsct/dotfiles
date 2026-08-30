#!/usr/bin/env bash
#                                                                _
#  ___  ___ _ __ ___  ___ _ __        _ __ ___  ___ ___  _ __ __| |
# / __|/ __| '__/ _ \/ _ \ '_ \ _____| '__/ _ \/ __/ _ \| '__/ _` |
# \__ \ (__| | |  __/  __/ | | |_____| | |  __/ (_| (_) | | | (_| |
# |___/\___|_|  \___|\___|_| |_|     |_|  \___|\___\___/|_|  \__,_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Import Current Theme
ROFI_CONFIG="$XDG_CONFIG_HOME/rofi/config-screenshots.rasi"

PIDFILE="/tmp/wf-recorder.pid"
VIDEOFILE="$HOME/Media/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"

start() {
    if [ $1 = "audio" ]; then
        wf-recorder -f $VIDEOFILE -a &
    else
        wf-recorder -f $VIDEOFILE &
    fi
    echo $! > "$PIDFILE"
}

stop() {
    if [[ -f "$PIDFILE" ]]; then
        kill -INT "$(cat "$PIDFILE")"
        rm "$PIDFILE"
        dunstify -u low --replace=699 "Recording saved at $VIDEOFILE"
    fi
}

option_1="    Record Screen"
option_2="    Record Screen with Audio"
option_3="    Stop Recording"

# Rofi CMD
rofi_cmd() {
	rofi -disable-history \
		-dmenu \
		-markup-rows \
		-config "${ROFI_CONFIG}" \
        -theme-str "listview {columns: 1; lines: 2;}"
}

rofi_cmd_stop() {
	rofi -disable-history \
		-dmenu \
		-markup-rows \
		-config "${ROFI_CONFIG}" \
		-theme-str "listview {columns: 1; lines: 1;}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2" | rofi_cmd
}

run_rofi_stop() {
	echo -e "$option_3" | rofi_cmd_stop
}

if [ -f "$PIDFILE" ]; then
    chosen="$(run_rofi_stop)"
    case ${chosen} in
        "$option_3")
            stop
            ;;
    esac
else
    chosen="$(run_rofi)"
    case ${chosen} in
        "$option_1")
            start
            ;;
        "$option_2")
            start audio
            ;;
    esac
fi
