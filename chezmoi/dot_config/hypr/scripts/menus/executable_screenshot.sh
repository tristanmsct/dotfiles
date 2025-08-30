#!/usr/bin/env bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Import Current Theme
theme="$HOME/.config/rofi/config-screenshots.rasi"

mesg="Saved At: $(xdg-user-dir PICTURES)/Screenshots"

option_1="󰍺    Capture All"
option_2="    Capture Active"
option_3="    Capture Window"
option_4="    Capture Area"
option_5="󱎫    Capture in 5s"
option_6="󱎫    Capture in 10s"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: 680px;}" \
		-theme-str "listview {columns: 1; lines: 6;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-mesg "$mesg" \
		-markup-rows \
		-theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Filename creation
time_stamp=$(date +%Y-%m-%d-%H-%M-%S)
# For full screenshot geometry we use hyprctl via wlr-randr if needed
geometry=$(wlr-randr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time_stamp}.png"

[ ! -d "$dir" ] && mkdir -p "$dir"

# Notify and view screenshot (using dunstify and viewnior)
notify_view() {
	notify_cmd_shot='dunstify -u low --replace=699'
	$notify_cmd_shot "Copied to clipboard."
	viewnior "${dir}/$file"
	if [[ -e "$dir/$file" ]]; then
		$notify_cmd_shot "Screenshot Saved."
	else
		$notify_cmd_shot "Screenshot Deleted."
	fi
}

# Copy screenshot to clipboard using wl-copy
copy_shot () {
	# Write image to file and pipe the same image to wl-copy
	tee "$file" | wl-copy -t image/png
}

# Countdown function
countdown () {
	for sec in $(seq $1 -1 1); do
		dunstify -t 1000 --replace=699 "Taking shot in: $sec"
		sleep 1
	done
}

# Helper: Get active window geometry using hyprctl and jq
active_geometry() {
	hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

# Take screenshot functions using grim and slurp:
shotnow () {
	cd "$dir" && sleep 0.5 && grim -t png - | copy_shot
	notify_view
}

shot5 () {
	countdown 5
	sleep 1 && cd "$dir" && grim -t png - | copy_shot
	notify_view
}

shot10 () {
	countdown 10
	sleep 1 && cd "$dir" && grim -t png - | copy_shot
	notify_view
}

shotwin () {
	# Capture active window using geometry from swaymsg
	geom=$(active_geometry)
	cd "$dir" && sleep 0.5 && grim -g "$geom" -t png - | copy_shot
	notify_view
}

shotactive () {
	cd "$dir" && sleep 0.5 && grim -o $(hyprctl activeworkspace -j | jq -r '.monitor') -t png - | copy_shot
	notify_view
}

shotarea () {
	# Let the user select an area using slurp
	cd "$dir" && grim -g "$(slurp)" -t png - | copy_shot
	notify_view
}

# Execute Command based on option chosen
run_cmd() {
	case "$1" in
		--opt1) shotnow ;;
		--opt2) shotactive ;;
		--opt3) shotwin ;;
		--opt4) shotarea ;;
		--opt5) shot5 ;;
		--opt6) shot10 ;;
	esac
}

# Rofi selection and action dispatch
chosen="$(run_rofi)"
case ${chosen} in
    "$option_1")
		run_cmd --opt1
        ;;
    "$option_2")
		run_cmd --opt2
        ;;
    "$option_3")
		run_cmd --opt3
        ;;
    "$option_4")
		run_cmd --opt4
        ;;
    "$option_5")
		run_cmd --opt5
        ;;
esac
