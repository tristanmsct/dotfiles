#!/usr/bin/env bash
#                _
#  ___ _   _ ___| |_ ___ _ __ ___         __ _  __ _  ___
# / __| | | / __| __/ _ \ '_ ` _ \ _____ / _` |/ _` |/ _ \
# \__ \ |_| \__ \ ||  __/ | | | | |_____| (_| | (_| |  __/
# |___/\__, |___/\__\___|_| |_| |_|      \__,_|\__, |\___|
#      |___/                                   |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

# Get filesystem birth time (seconds since epoch). Use stat -c %%W which
# returns birth time in seconds or 0/-1 if unavailable.
birth=$(stat -c %W / 2>/dev/null)
now=$(date +%s)

# Validate birth time
if [[ -z "$birth" || "$birth" -le 0 ]]; then
	echo "unknown"
	exit 0
fi

diff=$(( now - birth ))

# Compute years (~365 days), months (~30 days), days, hours
total_days=$(( diff / 86400 ))
years=$(( total_days / 365 ))
months=$(( (total_days % 365) / 30 ))
days=$(( total_days % 30 ))
hours=$(( (diff % 86400) / 3600 ))

if [[ $years -gt 0 ]]; then
	printf "%d years, %d months, %d days, %d hours\n" "$years" "$months" "$days" "$hours"
elif [[ $months -gt 0 ]]; then
	printf "%d months, %d days, %d hours\n" "$months" "$days" "$hours"
else
	printf "%d days, %d hours\n" "$days" "$hours"
fi
