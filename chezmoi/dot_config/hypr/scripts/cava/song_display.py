#!/usr/bin/env python3
"""
Created on 2025-05-03.

@author: Tristan Muscat
@email: tristan.muscat@pm.me

Display the title and artist of the currently playing media.
If the resulting string is too long then the text will scroll from side to side.
Obviously if several media are playing at the same time, the result can get a bit wonky.
Only the media started last should show, in theory.
"""
import configparser
import os
import shutil
import signal
import subprocess
import sys
import time

CAVA_CONFIG_FILE = "~/.config/cava/config_mini"


def get_playerctl_metadata():
    """Get artist and title from playerctl metadata."""
    try:
        artist = subprocess.check_output(["playerctl", "metadata", "xesam:artist"], stderr=subprocess.DEVNULL).decode().strip()
        title = subprocess.check_output(["playerctl", "metadata", "xesam:title"], stderr=subprocess.DEVNULL).decode().strip()

        # Check if we have both artist and title, or just title.
        if artist and title:
            return f"{artist} - {title}"
        elif title:
            return title
        else:
            return "No media playing"
    except subprocess.CalledProcessError:
        return "No media playing"


def scroll_text(text, width, position):
    """Create a scrolling text effect."""
    # Pad text with spaces at the end for continuous scrolling.
    padding = "  //  "
    padded_text = text + padding + text[:width]

    # Ensure position wraps around.
    effective_pos = position % (len(text + padding))

    # Return the visible portion.
    return padded_text[effective_pos:(effective_pos + width)]


def get_cava_color():
    """Read cava main color from its config file."""
    config = configparser.ConfigParser()
    config.read(os.path.expanduser(CAVA_CONFIG_FILE))

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
        # Get terminal width.
        terminal_width = shutil.get_terminal_size().columns - 1  # -1 for safety.

        position = 0
        last_metadata = ""

        while True:
            # color = accent_color
            # Get current metadata.
            current_metadata = get_playerctl_metadata()

            # Reset position when metadata changes.
            if current_metadata != last_metadata:
                position = 0
                last_metadata = current_metadata

            # Only scroll if text is longer than terminal width.
            if len(current_metadata) > terminal_width:
                display_text = scroll_text(current_metadata, terminal_width, position)
                position += 1

                # Reset position to 0 so it does not continually increase to infinity. I'm not sure if it would be a problem or not.
                # The +6 here is to account for the padding at the end of the string. If the padding is changed, this should be adapted.
                if (position % (len(current_metadata) + 6)) == 0:
                    position = 0
            else:
                display_text = current_metadata.ljust(terminal_width)

            # Apply color to text if a color was found.
            if color:
                # Convert color to ANSI escape sequence.
                if color.startswith("#"):
                    r = int(color[1:3], 16)
                    g = int(color[3:5], 16)
                    b = int(color[5:7], 16)
                    display_text = f"\033[38;2;{r};{g};{b}m{display_text}\033[0m"

            # Clear line and print.
            print(f"\r{display_text}", end="", flush=True)

            # Sleep for a bit (controls scroll speed).
            time.sleep(0.2)

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
