#!/usr/bin/env bash
#  _                                               _        _   _                          _            _
# | |__  _   _ _ __  _ __ ___ _   _ _ __  ___  ___| |_     | |_(_)_ __ ___   ___ _ __     | |_ ___  ___| |_
# | '_ \| | | | '_ \| '__/ __| | | | '_ \/ __|/ _ \ __|____| __| | '_ ` _ \ / _ \ '__|____| __/ _ \/ __| __|
# | | | | |_| | |_) | |  \__ \ |_| | | | \__ \  __/ ||_____| |_| | | | | | |  __/ | |_____| ||  __/\__ \ |_
# |_| |_|\__, | .__/|_|  |___/\__,_|_| |_|___/\___|\__|     \__|_|_| |_| |_|\___|_|        \__\___||___/\__|
#        |___/|_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1091

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source "$SCRIPT_DIR/hyprsunset-timer.sh"

passed=0
failed=0

assert_equal() {
    local name="$1"
    local expected="$2"
    local actual="$3"

    if [[ "$actual" == "$expected" ]]; then
        printf 'PASS %s\n' "$name"
        passed=$((passed + 1))
    else
        printf 'FAIL %s: expected %s, got %s\n' "$name" "$expected" "$actual"
        failed=$((failed + 1))
    fi
}

assert_equal 'normalize 08:30' '510' "$(normalize_time '08' '30')"
assert_equal 'normalize midnight' '0' "$(normalize_time '00' '00')"

assert_equal 'sunrise starts at 4700 K' 'sunrise 4700' "$(calculate_schedule 480 480 1020)"
assert_equal 'sunrise continues at 5500 K' 'sunrise 5500' "$(calculate_schedule 525 480 1020)"
assert_equal 'sunrise ends at 6500 K' 'sunrise 6500' "$(calculate_schedule 570 480 1020)"
assert_equal 'daytime has no modifier' 'day' "$(calculate_schedule 571 480 1020)"
assert_equal 'sunset starts at 6300 K' 'sunset 6300' "$(calculate_schedule 1020 480 1020)"
assert_equal 'sunset continues at 5700 K' 'sunset 5700' "$(calculate_schedule 1050 480 1020)"
assert_equal 'sunset ends at 4500 K' 'sunset 4500' "$(calculate_schedule 1110 480 1020)"
assert_equal 'nighttime is 4500 K' 'night 4500' "$(calculate_schedule 1111 480 1020)"
assert_equal 'pre-morning time is night' 'night 4500' "$(calculate_schedule 60 480 1020)"
assert_equal 'sunset overflow at 00:10 is 4500 K' 'sunset 5300' "$(calculate_schedule 10 480 1400)"

calendar_file="$SCRIPT_DIR/hyprsunset-calendar.json"

for month in 01 02 03 04 05 06 07 08 09 10 11 12; do
    if calendar_times=$(load_calendar_times "$calendar_file" "$month"); then
        read -r morning_start evening_start <<< "$calendar_times"
        if [[ "$morning_start" =~ ^[0-9]+$ && "$evening_start" =~ ^[0-9]+$ ]]; then
            printf 'PASS calendar month %s\n' "$month"
            passed=$((passed + 1))
        else
            printf 'FAIL calendar month %s: invalid values\n' "$month"
            failed=$((failed + 1))
        fi
    else
        printf 'FAIL calendar month %s: missing entry\n' "$month"
        failed=$((failed + 1))
    fi
done

printf '\n%d passed, %d failed\n' "$passed" "$failed"
(( failed == 0 ))
