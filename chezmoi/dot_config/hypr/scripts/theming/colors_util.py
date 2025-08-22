#!/usr/bin/env python
"""
Created on 2025-03-22.

@author: Tristan Muscat
"""

import colorsys
import math
from collections import namedtuple

# hex_match_color is the color used to find the best match. Colors are adjusted to get less brown, black, etc.
# hex_tela_color is the actual color of the tela theme.
# orchis_match is the matching orchist theme color.
Color = namedtuple("Color", ["hex_match_color", "hex_tela_color", "orchis_match"])

# Define a dictionary of "human" colors with their hex codes.
TELA_COLORS = {
    "black": Color("#101010", "#4D4D4D", "Grey"),
    "blue": Color("#4863d3", "#5677fC", "Blue"),
    'brown': Color('#523226c', "#795548", "Red"),
    "green": Color("#63B567", "#66BB6A", "Green"),
    "grey": Color("#C8C8C8", "#BDBDBD", "Grey"),
    "manjaro": Color("#1AC3A2", "#16A085", "Teal"),
    "nord": Color("#292e38", "#4D576A", "Grey"),
    "orange": Color("#F08F00", "#FF9800", "Orange"),
    "pink": Color("#BE4D73", "#F06292", "Pink"),
    "purple": Color("#7652B7", "#7E57C2", "Purple"),
    "red": Color("#E44F4C", "#Ef5350", "Red"),
    "ubuntu": Color("#D77137", "#FB8441", "Orange"),
    "yellow": Color("#C59C1E", "#FFCA28", "Yellow"),
}

# Orchis hex colors.
ORCHIS_COLORS = {
    "Blue": "#3a7be0",
    "Green": "#66bb6a",
    "Grey": "#dddddd",
    "Orange": "#fb8c00",
    "Pink": "#f06292",
    "Purple": "#ad60b9",
    "Red": "#f44336",
    "Teal": "#4db6ac",
    "Yellow": "#fbc02d",
}


def increase_saturation(hex_color, res_type="hex", sat_increase=0.5, brightness_adjust=0.1):
    """Increase the saturation and birghtness of a hex color."""
    # Remove '#' if present.
    hex_color = hex_color.lstrip("#")

    # Convert hex to RGB (0-1 range).
    red = int(hex_color[0:2], 16) / 255.0
    green = int(hex_color[2:4], 16) / 255.0
    blue = int(hex_color[4:6], 16) / 255.0

    # Convert RGB to HLS.
    hue, lightness, saturation = colorsys.rgb_to_hls(red, green, blue)

    # Increase saturation (clamping to 1.0 maximum).
    saturation = min(1.0, saturation + sat_increase)
    lightness = min(1.0, lightness + brightness_adjust)

    # Convert back to RGB.
    red, green, blue = colorsys.hls_to_rgb(hue, lightness, saturation)

    result = None
    if res_type == "hex":
        result = "#{:02x}{:02x}{:02x}".format(int(red * 255), int(green * 255), int(blue * 255))
    elif res_type == "rgba":
        result = f"rgba({int(red * 255)},{int(green * 255)},{int(blue * 255)},1)"
    else:
        print("Wrong result type provided.")

    return result


def hex_to_rgb(hex_color):
    """Convert a hex color string to a (R, G, B) tuple."""
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) for i in (0, 2, 4))


def rgb_to_hex(r, g, b):
    """Convert a (R, G, B) tuple to a hex color string."""
    return f'#{r:02X}{g:02X}{b:02X}'


def weighted_rgb_distance(c1, c2):
    """Calculate weighted RGB distance that reduces brightness impact."""
    r_diff = c1[0] - c2[0]
    g_diff = c1[1] - c2[1]
    b_diff = c1[2] - c2[2]

    # Weight the differences - reduce overall magnitude impact
    brightness_diff = (r_diff + g_diff + b_diff) / 3

    # Subtract brightness component to focus more on hue/saturation
    r_adjusted = r_diff - brightness_diff * 0.5
    g_adjusted = g_diff - brightness_diff * 0.5
    b_adjusted = b_diff - brightness_diff * 0.5

    return math.sqrt(r_adjusted**2 + g_adjusted**2 + b_adjusted**2)


def rgb_distance(c1, c2):
    """Calculate the Euclidean distance between two RGB colors."""
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(c1, c2)))


def normalize_brightness(rgb, target_brightness=128):
    """Normalize RGB color to target brightness while preserving hue/saturation."""
    current_brightness = sum(rgb) / 3
    if current_brightness == 0:
        return (target_brightness, target_brightness, target_brightness)

    scale = target_brightness / current_brightness
    return tuple(min(255, int(color * scale)) for color in rgb)


def get_closest_color(hex_color, color_dict):
    """Return the human-readable color name closest to the given hex color."""
    rgb = hex_to_rgb(hex_color)
    rgb = normalize_brightness(rgb)

    best_match = None
    best_distance = float("inf")
    for name, item in color_dict.items():
        ref_rgb = hex_to_rgb(item.hex_match_color)
        # ref_rgb = normalize_brightness(ref_rgb)
        distance = weighted_rgb_distance(rgb, ref_rgb)
        if distance < best_distance:
            best_distance = distance
            best_match = name

    return best_match


def validate_hex_format(hex_str):
    return (len(hex_str) == 7) and (hex_str[0] == "#")
