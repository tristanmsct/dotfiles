#                                          __ _
#   ___ __ ___   ____ _    ___ ___  _ __  / _(_) __ _
#  / __/ _` \ \ / / _` |  / __/ _ \| '_ \| |_| |/ _` |
# | (_| (_| |\ V / (_| | | (_| (_) | | | |  _| | (_| |
#  \___\__,_| \_/ \__,_|  \___\___/|_| |_|_| |_|\__, |
#                                               |___/
#
# -----------------------------------------------------------------------------------------------------------------------------------------

[general]
# Set a higher bar threshold so small values don't register
bar_threshold = 10

# Make sure bars start from 0 height
zero_delimiter = 0

# Manual sensitivity in %. If autosens is enabled, this will only be the initial value.
# 200 means double height. Accepts only non-negative values.
sensitivity = 60

# The number of bars (0-512). 0 sets it to auto (fill up console).
# Bars' width and space between bars in number of characters.
; bars = 0
bar_width = 1
; bar_spacing = 1
# bar_height is only used for output in "noritake" format
; bar_height = 32

[color]
# Gradient mode, only hex defined colors are supported,
# background must also be defined in hex or remain commented out. 1 = on, 0 = off.
# You can define as many as 8 different colors. They range from bottom to top of screen
# include $HOME/.cache/wal/colors-cava.conf
; foreground = <COLOR>
gradient = 1
gradient_count = 2
gradient_color_1 = <COLOR>
gradient_color_2 = '#ffffff'

; Not used, kept just in case.
; gradient_color_1 = <COLOR1>
; gradient_color_2 = <COLOR2>
; gradient_color_3 = <COLOR3>
; gradient_color_4 = <COLOR4>
; gradient_color_5 = <COLOR5>
; gradient_color_6 = <COLOR6>
; gradient_color_7 = <COLOR7>
; gradient_color_8 = <COLOR8>

[output]
orientation = horizontal
channels = mono
