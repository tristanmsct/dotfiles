--  _              _     _           _ _
-- | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
-- | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
-- |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
-- |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
--           |___/                             |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local SCRIPTS = os.getenv("DESKTOP_SCRIPTS")

local TYPORA_FILE = os.getenv("HOME") .. '/Nextcloud/03-Notes/Day-to-day/' .. os.date('%Y-%m-%d') .. '-notes.md'

local e = hl.dsp.exec_cmd

-- --------------------------------------------------------------------------------------
-- Importing lua functions
-- --------------------------------------------------------------------------------------
local toggle_allfloat = dofile(SCRIPTS .. "/hyprland/workspaces/all-float.lua")
local toggle_float_window = dofile(SCRIPTS .. "/hyprland/workspaces/float-window.lua")
local move_to_empty = dofile(SCRIPTS .. "/hyprland/workspaces/move-to-empty.lua")
local move_to_end = dofile(SCRIPTS .. "/hyprland/workspaces/move-to-end.lua")

-- --------------------------------------------------------------------------------------
-- Applications
-- --------------------------------------------------------------------------------------
hl.bind("SUPER + RETURN", e("kitty"), { description = "Open Kitty terminal" })
hl.bind("SUPER + B", e("brave"), { description = "Open Brave web browser" })
hl.bind("SUPER + E", e("nautilus"), { description = "Open file manager" })
hl.bind("SUPER + ALT + E", e("nautilus -s " .. os.getenv("HOME") .. "/Nextcloud/03-Notes/Wikis/Computers/Linux"), { description = "Open file manager in wikis" })
hl.bind("SUPER + SHIFT + E", e("kitty --app-id yazi -e yazi"), { description = "Open Yazi" })
hl.bind("SUPER + N", e("typora " .. TYPORA_FILE), { description = "Open Typora with today's notes" })
hl.bind("SUPER + SHIFT + N", e("[float;size 800 400;move 1000 100] typora " .. TYPORA_FILE), { description = "Open floating Typora with today's notes" })
hl.bind("SUPER + CTRL + N", e("typora " .. os.getenv("HOME") .. "/Nextcloud/03-Notes/Wikis"), { description = "Open Typora with wikis" })
hl.bind("SUPER + S", e("subl"), { description = "Open Sublime Text" })
hl.bind("SUPER + X", e("codium"), { description = "Open VSCodium" })
hl.bind("SUPER + CTRL + X", e("kitty --app-id gopen -e gopen"), { description = "Open a common directory in VSCodium" })
hl.bind("SUPER + CTRL + E", e(SCRIPTS .. "/menus-rofi/emoji-picker.sh"), { description = "Open emoji picker" })
hl.bind("SUPER + G", e("steam"), { description = "Open Steam" })
hl.bind("SUPER + M", e("gapplication launch org.gnome.Weather"), { description = "Open Weather app" })

-- --------------------------------------------------------------------------------------
-- Windows
-- --------------------------------------------------------------------------------------
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen(), { description = "Fullscreen active window" })
hl.bind("SUPER + T", toggle_float_window, { description = "Toggle floating" })
hl.bind("SUPER + SHIFT + T", toggle_allfloat, { description = "Float all window in a workspace"})
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { description = "Move window with mouse", mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { description = "Resize window with mouse", mouse = true })
-- hl.bind("SUPER + ALT + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind("SUPER + J", hl.dsp.layout("orientationcycle left right"), { description = "Cycle master orientation" })
hl.bind("SUPER + K", hl.dsp.layout("swapwithmaster"), { description = "Swap focused window with master" })

-- --------------------------------------------------------------------------------------
-- Actions
-- --------------------------------------------------------------------------------------
hl.bind("SUPER + SHIFT + R", e("hyprctl reload"), { description = "Reload Hyprland config" })
hl.bind("SUPER + CTRL + V", e(SCRIPTS .. "/menus-rofi/cliphist.sh"), { description = "Open clipboard manager" })
hl.bind("SUPER + CTRL + K", e(SCRIPTS .. "/menus-rofi/keybindings.sh"), { description = "Show keybindings" })
hl.bind("SUPER + SHIFT + K", e(SCRIPTS .. "/menus-rofi/aliases.sh"), { description = "Show aliases" })
hl.bind("SUPER + CTRL + RETURN",
    e("pkill rofi || rofi -show drun -replace -i -disable-history -config '" .. os.getenv("HOME") .. "/.config/rofi/config-appmenu.rasi'"),
    { description = "Open application launcher" }
)
hl.bind("SUPER + SHIFT + RETURN",
    e('pkill rofi || rofi -show drun -disable-history -config "' .. os.getenv("HOME") .. '/.config/rofi/config-run.rasi"'),
    { description = "Open command runner" }
)
hl.bind("SUPER + SHIFT + CTRL + RETURN", e(os.getenv("HOME") .. "/.config/nwg-drawer/drawer-start.sh"), { description = "Open NWG application launcher" })

hl.bind("CTRL + Escape", e("hyprlock --grace 3"), { description = "Lock screen" })
hl.bind("SUPER + L", e("hyprlock --grace 3"), { description = "Lock screen" })
-- hl.bind("XF86PowerOff", e("pkill wlogout || wlogout -b 2"), { description = "Open logout menu" }, { locked = true })
hl.bind("SUPER + CTRL + Q", e("pkill wlogout || wlogout -b 2"), { description = "Open logout menu" })

hl.bind("SUPER + PRINT", e(SCRIPTS .. "/menus-rofi/screenshot.sh"), { description = "Take a screenshot" })
hl.bind("SUPER + CTRL + S", e(SCRIPTS .. "/menus-rofi/screenshot.sh"), { description = "Take a screenshot" })
hl.bind("SUPER + SHIFT + PRINT", e(SCRIPTS .. "/menus-rofi/screen-record.sh"), { description = "Start screen recording" })
hl.bind("SUPER + SHIFT + CTRL + S", e(SCRIPTS .. "/menus-rofi/screen-record.sh"), { description = "Start screen recording" })

hl.bind("SUPER + W", e("waypaper"), { description = "Open wallpaper selector" })
hl.bind("SUPER + SHIFT + W", e("waypaper --random"), { description = "Random wallpaper" })
hl.bind("SUPER + CTRL + W", e("waypaper --restore"), { description = "Restore wallpaper" })
hl.bind("SUPER + ALT + W", e("awww kill"), { description = "Stop Awww" })

hl.bind("SUPER + SHIFT + B", e(SCRIPTS .. "/waybar/launch.sh"), { description = "Reload Waybar" })
hl.bind("SUPER + CTRL + B", e(SCRIPTS .. "/waybar/toggle.sh"), { description = "Toggle Waybar" })
hl.bind("SUPER + CTRL + G", e(SCRIPTS .. "/focus-mode/activate.sh"), { description = "Toggle focus mode" })
hl.bind("SUPER + SHIFT + G", e("rofi -disable-history -modi games -show games -theme config-games"), { description = "Open game launcher" })
hl.bind("SUPER + ALT + G", e(SCRIPTS .. "/focus-mode/btop-overlay.sh"), { description = "Display btop overlay" })

hl.bind("SUPER + Y", e(SCRIPTS .. "/hyprland/hyprsunset/hyprsunset.sh"), { description = "Toggle Hyprsunset" })

hl.bind("SUPER + P", e(SCRIPTS .. "/menus-rofi/monitor-menu.sh"), { description = "Monitor configuration menu" })
hl.bind("SUPER + CTRL + F", e(SCRIPTS .. "/media/audio-helper.sh"), { description = "Fix audio device" })

hl.bind("SUPER + V", e(SCRIPTS .. "/menus-rofi/vpn.sh"), { description = "Open VPN menu" })

hl.bind("SUPER + C", e(SCRIPTS .. "/menus-eww/themes/display-theme-menu.sh"), { description = "Open theme and colors menu" })
hl.bind("SUPER + SHIFT + C", e(SCRIPTS .. "/menus-eww/brightness/display-brightness-menu.sh"), { description = "Open brightness menu" })
hl.bind("SUPER + CTRL + C", e("hyprpicker -a"), { description = "Open color picker" })
hl.bind("SUPER + SHIFT + L", e(SCRIPTS .. "/theming/switch-theme.sh"), { description = "Switch light/dark theme" })

hl.bind("SUPER + U", e(SCRIPTS .. "/cava/overlay.sh"), { description = "Toggle Cava overlay" })
hl.bind("SUPER + CTRL + SHIFT + U", e(SCRIPTS .. "/cava/quickshell-overlay.sh"), { description = "Toggle Turbo Cava" })
hl.bind("SUPER + SHIFT + U", e(SCRIPTS .. "/cava/overlay.sh mini"), { description = "Toggle Cava mini overlay" })
hl.bind("SUPER + CTRL + U", e(SCRIPTS .. "/cava/overlay.sh mini title"), { description = "Toggle Cava mini overlay with title" })
hl.bind("SUPER + ALT + U", e(SCRIPTS .. "/cava/input-switch.sh"), { description = "Switch Cava input source" })
hl.bind("SUPER + I", e(SCRIPTS .. "/focus-mode/clock-overlay.sh"), { description = "Toggle clock overlay" })

hl.bind("SUPER + comma", e("kitty --app-id btop -e btop"), { description = "Open btop" })
hl.bind("SUPER + CTRL + comma", e("missioncenter"), { description = "Open Mission Center" })
hl.bind("SUPER + SHIFT + comma", e("kitty --session " .. os.getenv("HOME") .. "/.config/kitty/sessions/dev-layout.conf"), { description = "Open kitty dev layout" })
hl.bind("SUPER + A", e("kitty --session " .. os.getenv("HOME") .. "/.config/kitty/sessions/animation-layout.conf"), { description = "Open kitty animation layout" })

hl.bind("SUPER + SHIFT + D", e("dunstctl history-pop"), { description = "Replay last notification" })

hl.bind("SUPER + ALT + C", e("networkpwd"), { description = "Show wifi network password" })

hl.bind("SUPER + SHIFT + P", e("gtk-launch cheatsheet.desktop"), { description = "Show a system paths cheat sheet" })

-- --------------------------------------------------------------------------------------
-- Workspaces
-- --------------------------------------------------------------------------------------
hl.bind("SUPER + Z", move_to_empty, { description = "Send window to next empty workspace" })
hl.bind("SUPER + SHIFT + Z", move_to_end, { description = "Send window to last workspace" })
hl.bind("SUPER + CTRL + Z", e("python " .. SCRIPTS .. "/hyprland/workspaces/compact_workspaces.py"), { description = "Compact workspaces" })

hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace" })
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace", mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace", mouse = true })
hl.bind("SUPER + CTRL + down", hl.dsp.focus({ workspace = "empty" }), { description = "Next empty workspace" })

-- Toggle the special workspace visibility.
hl.bind("SUPER + SHIFT + H", hl.dsp.workspace.toggle_special("minimized"), { description = "Open minimized workspace" })

-- Put a single window in a minimized state and get it back.
hl.bind("SUPER + H", function ()
    if hl.get_workspace("special:minimized") then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
    else
        hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    end
end, { description = "Toggle window minimized state" })

-- Move focused window into it.
hl.bind("SUPER + CTRL + H", function ()
    hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
end, { description = "Move window to minimized workspace" })

-- Get a window back from the minimized workspace.
hl.bind("SUPER + SHIFT + CTRL + H", function ()
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
    hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
end, { description = "Move window to minimized workspace" })

-- --------------------------------------------------------------------------------------
-- Fn keys
-- --------------------------------------------------------------------------------------
-- In order using `xbindkeys --key` to find out :
-- XF86Launch1, XF86MonBrightnessDown, XF86MonBrightnessUp, meta + P, ?, XF86AudioMute, XF86AudioLowerVolume, XF86AudioRaiseVolume, ?
-- ?, ?, ?, ?, ?, XF86Lock
hl.bind("XF86MonBrightnessDown", e("brightnessctl -q s 10%-"), { description = "Decrease brightness" })
hl.bind("XF86MonBrightnessUp", e("brightnessctl -q s +10%"), { description = "Increase brightness" })
hl.bind("XF86AudioMute", e("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Toggle mute" })
hl.bind("XF86AudioLowerVolume", e("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { description = "Decrease volume" })
hl.bind("XF86AudioRaiseVolume", e("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { description = "Increase volume" })

-- --------------------------------------------------------------------------------------
-- Other
-- --------------------------------------------------------------------------------------
-- hl.bind("SUPER + O", e("gapplication launch org.gnome.Weather"))
-- hl.bind("SUPER + O", e(SCRIPTS .. "/focus-mode/btop-overlay.sh"))
