#!/usr/bin/env python
#                                          _
#   ___ ___  _ ____   _____ _ __  ___ ___ | | ___  _ __ ___
#  / __/ _ \| '_ \ \ / / _ \ '__|/ __/ _ \| |/ _ \| '__/ __|
# | (_| (_) | | | \ V /  __/ |  | (_| (_) | | (_) | |  \__ \
#  \___\___/|_| |_|\_/ \___|_|___\___\___/|_|\___/|_|  |___/
#                           |_____|
#
"""
Created on 2025-02-05.

@author: Tristan

This script converts wallust colors to "human" colors corresponding to Tela Circle icons theme and Orchis Theme.
"""
import argparse
import os
from random import random

from colors_util import TELA_COLORS
from colors_util import get_closest_color
from colors_util import validate_hex_format


def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--color", type=str, help="A color to improve in a hex format '#RRGGBB'", default=None)
    parser.add_argument("-d", "--dracula", action="store_true", help="Uses Dracula theme randomly instead of black, purple or pink colors")

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    # There are two scenarios :
    # No argument then we get the first color from the theme.
    # If there is a specified color then we return the closest to this one.
    if args.color and validate_hex_format(args.color):
        tela_theme = get_closest_color(args.color, TELA_COLORS)
    else:
        # Read the main color from the .local/state/desktop/colors file.
        with open(os.environ["HOME"] + "/.local/state/desktop/colors", "r") as f:
            first_color = f.read().splitlines()[0]
            tela_theme = get_closest_color(first_color, TELA_COLORS)

    orchis_theme = TELA_COLORS[tela_theme].orchis_match
    hex_color = TELA_COLORS[tela_theme].hex_tela_color

    if (args.dracula) and (tela_theme in ["black", "purple"]) and (random() <= 0.5):
        tela_theme = "dracula"

    # Print both color names and the hex value separated by a space for the shell script to parse.
    print(f"{tela_theme} {orchis_theme} {hex_color}")
