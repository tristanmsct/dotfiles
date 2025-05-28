#!/usr/bin/env python
"""
Created on 2025-03-22.

@author: Tristan Muscat
"""

import argparse

from colors_util import increase_saturation

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--color", type=str, help="A color to improve in a hex format '#RRGGBB'", default="#505050")
parser.add_argument("-t", "--res-type", type=str, help="Output format", choices=["hex", "rgba"], default="hex")
parser.add_argument("-s", "--sat-increase", type=float, help="Increase in saturation between 0 and 1", default=0.5)
parser.add_argument("-b", "--brightness-adjust", type=float, help="Adjustmen for brightness between 0 and 1", default=0.1)

if __name__ == "__main__":
    args = parser.parse_args()
    print(
        increase_saturation(
            hex_color=args.color, res_type=args.res_type, sat_increase=args.sat_increase, brightness_adjust=args.brightness_adjust
        )
    )
