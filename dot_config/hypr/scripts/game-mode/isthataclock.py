#!/usr/bin/env python
"""
Created on 2025-05-29.

@author: Tristan Muscat
@email: tristan.muscat@pm.me
"""
import os
import configparser
import sys
import time
import signal
from datetime import datetime

# Cava color syncs up with the theme so its a good source.
CAVA_CONFIG_FILE = os.getenv("HOME") + "/.config/cava/config_mini"


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
            now = datetime.now()
            display_text = now.strftime("%H:%M")

            # Apply color to text if a color was found.
            if color:
                # Convert color to ANSI escape sequence.
                if color.startswith("#"):
                    r = int(color[1:3], 16)
                    g = int(color[3:5], 16)
                    b = int(color[5:7], 16)
                    display_text = f"\033[38;2;{r};{g};{b}m{display_text}\033[0m"

            print(f"\r{display_text}", end="", flush=True)

            time.sleep(1)
    except Exception as e:
        print(f"\nError: {e}")
    finally:
        # Show cursor on exit.
        print("\033[?25h", end="")


if __name__ == "__main__":
    # Register signal handler
    color = get_cava_color()
    signal.signal(signal.SIGUSR1, reload_stylesheet)

    main()
