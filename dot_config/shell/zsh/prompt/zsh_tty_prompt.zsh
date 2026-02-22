#          _        _   _                                              _
#  _______| |__    | |_| |_ _   _      _ __  _ __ ___  _ __ ___  _ __ | |_
# |_  / __| '_ \   | __| __| | | |    | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#  / /\__ \ | | |  | |_| |_| |_| |    | |_) | | | (_) | | | | | | |_) | |_
# /___|___/_| |_|___\__|\__|\__, |____| .__/|_|  \___/|_| |_| |_| .__/ \__|
#              |_____|      |___/_____|_|                       |_|
#
# -----------------------------------------------------------------------------------------------------------------------------------------
# A simple prompt only for TTY.
# -----------------------------------------------------------------------------------------------------------------------------------------

# Monokai-inspired TTY colors.
echo -en "\e]P01E1E1E" # Black (Background)
echo -en "\e]P8504945" # Dark Grey
echo -en "\e]P1F92672" # Red (Pinkish Red)
echo -en "\e]P9FF669D" # Bright Red
echo -en "\e]P2A6E22E" # Green
echo -en "\e]PAB6F86F" # Bright Green
echo -en "\e]P3F4BF75" # Yellow (Soft Orange)
echo -en "\e]PBFFD75F" # Bright Yellow
echo -en "\e]P466D9EF" # Blue (Cyanish)
echo -en "\e]PC92E7FC" # Bright Blue
echo -en "\e]P5AE81FF" # Magenta (Purple)
echo -en "\e]PDCAA9FA" # Bright Magenta
echo -en "\e]P557E9C0" # Cyan (Turquoise)
echo -en "\e]PEA0F3D8" # Bright Cyan
echo -en "\e]P6E6DB74" # Orange (Light Yellow)
echo -en "\e]PFFFFFFF" # White (Foreground)
clear # Prevent color artifacts

PS1=$'\n%F{green}%n%F{white} at %F{cyan}%m%F{white} in %F{magenta}%~%f\n%F{yellow}%# %f'
PS2=$'%F{green}→ %F{white}'
