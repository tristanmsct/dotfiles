#       _            _           _ _           _
#   ___| | ___   ___| | __    __| (_)___ _ __ | | __ _ _   _
#  / __| |/ _ \ / __| |/ /   / _` | / __| '_ \| |/ _` | | | |
# | (__| | (_) | (__|   <   | (_| | \__ \ |_) | | (_| | |_| |
#  \___|_|\___/ \___|_|\_\___\__,_|_|___/ .__/|_|\__,_|\__, |
#                       |_____|         |_|            |___/
#
"""
Created on 2025-05-29.

@author: Tristan Muscat
@email: tristan.muscat@pm.me
"""
import configparser
import os
import signal
import sys
import time
from datetime import datetime

import pytz

# Cava color syncs up with the theme so its a good source.
CAVA_CONFIG_FILE = os.getenv("XDG_CONFIG_HOME") + "/cava/config_mini"


def get_cava_color():
    """Read cava main color from its config file."""
    config = configparser.ConfigParser()
    config.read(CAVA_CONFIG_FILE)

    try:
        color = config.get("color", "gradient_color_1").strip("'")
        return color
    except (configparser.NoSectionError, configparser.NoOptionError):
        # If color is missing or there is an error, returns None. This will be checked later to use a default color.
        # return None
        return None


def reload_stylesheet(signum, frame):
    global color
    color = get_cava_color()


def handle_exit(sig, frame):
    """Clean up before exiting."""
    print("\033[?25h", end="")  # Show cursor.
    sys.exit(0)


def main():
    # Register signal handlers for clean exit.
    signal.signal(signal.SIGINT, handle_exit)
    signal.signal(signal.SIGTERM, handle_exit)

    # Hide cursor.
    print("\033[?25l", end="")

    try:
        while True:
            now = datetime.now(pytz.timezone("Europe/Paris"))
            display_text = now.strftime("%H:%M")

            # Convert color to ANSI escape sequence.
            if color and color.startswith("#"):
                r = int(color[1:3], 16)
                g = int(color[3:5], 16)
                b = int(color[5:7], 16)
                display_text = f"\033[38;2;{r};{g};{b}m{display_text}\033[0m"

            print(f"\r{display_text}", end="", flush=True)

            time.sleep(1)
    except (OSError, ValueError) as e:
        print(f"\nError: {e}")
    finally:
        # Show cursor on exit.
        print("\033[?25h", end="")


if __name__ == "__main__":
    # Register signal handler
    color = get_cava_color()
    signal.signal(signal.SIGUSR1, reload_stylesheet)

    main()
