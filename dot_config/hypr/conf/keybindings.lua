--  _              _     _           _ _
-- | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
-- | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
-- |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
-- |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
--           |___/                             |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local mainMod = "SUPER"
local SCRIPTS = os.getenv("HOME") .. "/.local/bin"
local HYPRSCRIPTS = os.getenv("HOME") .. "/.config/hypr/scripts"
local HYPRLAUNCHERS = os.getenv("HOME") .. "/.config/hypr/launchers"

local TYPORA_FILE = os.getenv("HOME") .. '/Nextcloud/03-Notes/Day-to-day/' .. os.date('%Y-%m-%d') .. '-notes.md'

local e = hl.dsp.exec_cmd

-- --------------------------------------------------------------------------------------
-- Importing lua functions
-- --------------------------------------------------------------------------------------
local toggle_allfloat = dofile(HYPRSCRIPTS .. "/workspaces/all-float.lua")
local move_to_empty = dofile(HYPRSCRIPTS .. "/workspaces/move-to-empty.lua")
local move_to_end = dofile(HYPRSCRIPTS .. "/workspaces/move-to-end.lua")

-- --------------------------------------------------------------------------------------
-- Applications
-- --------------------------------------------------------------------------------------
hl.bind(mainMod .. " + RETURN", e("kitty"), { description = "Open Kitty terminal" })
hl.bind(mainMod .. " + B", e(HYPRLAUNCHERS .. "/brave.sh"), { description = "Open Brave web browser" })
hl.bind(mainMod .. " + E", e("nautilus"), { description = "Open file manager" })
hl.bind(mainMod .. " + ALT + E", e("nautilus -s " .. os.getenv("HOME") .. "/Nextcloud/03-Notes/Wikis/Computers/Linux"), { description = "Open file manager in wikis" })
hl.bind(mainMod .. " + SHIFT + E", e("kitty --app-id yazi -e yazi"), { description = "Open Yazi" })
hl.bind(mainMod .. " + N", e(HYPRLAUNCHERS .. "/typora.sh " .. TYPORA_FILE), { description = "Open Typora with today's notes" })
hl.bind(mainMod .. " + SHIFT + N", e("[float;size 800 400;move 1000 100] " .. HYPRLAUNCHERS .. "/typora.sh " .. TYPORA_FILE), { description = "Open floating Typora with today's notes" })
hl.bind(mainMod .. " + CTRL + N", e(HYPRLAUNCHERS .. "/typora.sh " .. os.getenv("HOME") .. "/Nextcloud/03-Notes/Wikis"), { description = "Open Typora with wikis" })
hl.bind(mainMod .. " + S", e("subl"), { description = "Open Sublime Text" })
hl.bind(mainMod .. " + X", e(HYPRLAUNCHERS .. "/codium.sh"), { description = "Open VSCodium" })
hl.bind(mainMod .. " + CTRL + E", e(HYPRSCRIPTS .. "/menus/emoji-picker.sh"), { description = "Open emoji picker" })
hl.bind(mainMod .. " + G", e(HYPRLAUNCHERS .. "/steam.sh"), { description = "Open Steam" })

-- --------------------------------------------------------------------------------------
-- Windows
-- --------------------------------------------------------------------------------------
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { description = "Fullscreen active window" })
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(mainMod .. " + SHIFT + T", toggle_allfloat)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { description = "Move window with mouse", mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = "Resize window with mouse", mouse = true })
-- hl.bind(mainMod .. " + ALT + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(mainMod .. " + J", hl.dsp.layout("orientationcycle left right"), { description = "Cycle master orientation" })
hl.bind(mainMod .. " + K", hl.dsp.layout("swapwithmaster"), { description = "Swap focused window with master" })

-- --------------------------------------------------------------------------------------
-- Actions
-- --------------------------------------------------------------------------------------
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland config" })
hl.bind(mainMod .. " + CTRL + V", e(HYPRSCRIPTS .. "/menus/cliphist.sh"), { description = "Open clipboard manager" })
hl.bind(mainMod .. " + CTRL + K", e(HYPRSCRIPTS .. "/menus/keybindings.sh"), { description = "Show keybindings" })
hl.bind(mainMod .. " + SHIFT + K", e(HYPRSCRIPTS .. "/menus/aliases.sh"), { description = "Show aliases" })
hl.bind(mainMod .. " + CTRL + RETURN", e("pkill rofi || rofi -show drun -replace -i -disable-history"), { description = "Open application launcher" })
hl.bind(mainMod .. " + SHIFT + RETURN", e('pkill rofi || rofi -show drun -disable-history -config "' .. os.getenv("HOME") .. '/.config/rofi/config-run.rasi"'), { description = "Open command runner" })

hl.bind("CTRL + Escape", e("hyprlock --grace 3"), { description = "Lock screen" })
hl.bind(mainMod .. " + L", e("hyprlock --grace 3"), { description = "Lock screen" })
hl.bind("XF86PowerOff", e("wlogout -b 2"), { description = "Open logout menu" })
hl.bind(mainMod .. " + CTRL + Q", e("wlogout -b 2"), { description = "Open logout menu" })

hl.bind(mainMod .. " + PRINT", e(HYPRSCRIPTS .. "/menus/screenshot.sh"), { description = "Take a screenshot" })
hl.bind(mainMod .. " + SHIFT + S", e(HYPRSCRIPTS .. "/menus/screenshot.sh"), { description = "Take a screenshot" })

hl.bind(mainMod .. " + W", e("waypaper"), { description = "Open wallpaper selector" })
hl.bind(mainMod .. " + SHIFT + W", e("waypaper --random"), { description = "Random wallpaper" })
hl.bind(mainMod .. " + CTRL + W", e("waypaper --restore"), { description = "Restore wallpaper" })
hl.bind(mainMod .. " + ALT + W", e("awww kill"), { description = "Stop Awww" })

hl.bind(mainMod .. " + SHIFT + B", e(HYPRSCRIPTS .. "/waybar/launch.sh"), { description = "Reload Waybar" })
hl.bind(mainMod .. " + CTRL + B", e(HYPRSCRIPTS .. "/waybar/toggle.sh"), { description = "Toggle Waybar" })
hl.bind(mainMod .. " + CTRL + G", e(HYPRSCRIPTS .. "/game-mode/activate.sh"), { description = "Toggle game mode" })
hl.bind(mainMod .. " + SHIFT + G", e("rofi -disable-history -modi games -show games -theme games"), { description = "Open game launcher" })
hl.bind(mainMod .. " + ALT + G", e(HYPRSCRIPTS .. "/game-mode/btop-overlay.sh"), { description = "Display btop overlay" })

hl.bind(mainMod .. " + Y", e(HYPRSCRIPTS .. "/hyprsunset/hyprsunset.sh"), { description = "Toggle Hyprsunset" })

hl.bind(mainMod .. " + P", e(HYPRSCRIPTS .. "/menus/monitor-menu.sh"), { description = "Monitor configuration menu" })
hl.bind(mainMod .. " + CTRL + F", e(HYPRSCRIPTS .. "/media/audio-helper.sh"), { description = "Fix audio device" })

hl.bind(mainMod .. " + V", e(HYPRSCRIPTS .. "/menus/vpn.sh"), { description = "Open VPN menu" })

hl.bind(mainMod .. " + C", e(HYPRSCRIPTS .. "/menus-eww/theme-menu.sh"), { description = "Open theme and colors menu" })
hl.bind(mainMod .. " + SHIFT + C", e(HYPRSCRIPTS .. "/menus-eww/brightness-menu.sh"), { description = "Open brightness menu" })
hl.bind(mainMod .. " + CTRL + C", e("hyprpicker -a"), { description = "Open color picker" })
hl.bind(mainMod .. " + SHIFT + L", e(HYPRSCRIPTS .. "/theming/switch-theme.sh"), { description = "Switch light/dark theme" })

hl.bind(mainMod .. " + U", e(HYPRSCRIPTS .. "/cava/cava-overlay.sh"), { description = "Toggle Cava overlay" })
hl.bind(mainMod .. " + SHIFT + U", e(HYPRSCRIPTS .. "/cava/cava-overlay.sh mini"), { description = "Toggle Cava mini overlay" })
hl.bind(mainMod .. " + CTRL + U", e(HYPRSCRIPTS .. "/cava/cava-overlay.sh mini title"), { description = "Toggle Cava mini overlay with title" })
hl.bind(mainMod .. " + I", e(HYPRSCRIPTS .. "/game-mode/clock-overlay.sh"), { description = "Toggle clock overlay" })

hl.bind(mainMod .. " + M", e("kitty --app-id btop -e btop"), { description = "Open btop" })
hl.bind(mainMod .. " + CTRL + M", e("missioncenter"), { description = "Open Mission Center" })
hl.bind(mainMod .. " + SHIFT + M", e("kitty --session " .. os.getenv("HOME") .. "/.config/kitty/sessions/dev-layout.conf"), { description = "Open kitty dev layout" })
hl.bind(mainMod .. " + A", e("kitty --session " .. os.getenv("HOME") .. "/.config/kitty/sessions/animation-layout.conf"), { description = "Open kitty animation layout" })

hl.bind(mainMod .. " + SHIFT + D", e("dunstctl history-pop"), { description = "Replay last notification" })

-- --------------------------------------------------------------------------------------
-- Workspaces
-- --------------------------------------------------------------------------------------
hl.bind(mainMod .. " + Z", move_to_empty, { description = "Send window to next empty workspace" })
hl.bind(mainMod .. " + SHIFT + Z", move_to_end, { description = "Send window to last workspace" })
hl.bind(mainMod .. " + CTRL + Z", e("python " .. HYPRSCRIPTS .. "/workspaces/compact_workspaces.py"), { description = "Compact workspaces" })

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace" })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace", mouse = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace", mouse = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }), { description = "Next empty workspace" })

-- Toggle the special workspace visibility.
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.workspace.toggle_special("minimize"))

-- Move focused window into it.
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ workspace = "special:minimize", follow = false }))

-- Put a single window in a minimized state and get it back.
hl.bind(mainMod .. " + H", function ()
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({workspace = "+0"}))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({workspace = "special:minimize"}))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)

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
-- hl.bind(mainMod .. " + O", e(SCRIPTS .. "/openall.sh"))
-- hl.bind(mainMod .. " + O", e(HYPRSCRIPTS .. "/game-mode/btop-overlay.sh"))
