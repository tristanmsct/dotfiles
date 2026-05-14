--              _            _             _
--   __ _ _   _| |_ ___  ___| |_ __ _ _ __| |_
--  / _` | | | | __/ _ \/ __| __/ _` | '__| __|
-- | (_| | |_| | || (_) \__ \ || (_| | |  | |_
--  \__,_|\__,_|\__\___/|___/\__\__,_|_|   \__|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local HYPRSCRIPTS   = os.getenv("HOME") .. "/.config/hypr/scripts"
local HYPRLAUNCHERS = os.getenv("HOME") .. "/.config/hypr/launchers"

hl.on("hyprland.start", function()
    local function exec(cmd)
        hl.dispatch(hl.dsp.exec_cmd(cmd))
    end

    exec("/home/tristan/.config/hypr/scripts/system/setup-state.sh")

    -- Clean Home Directory / Set up state
    exec(HYPRSCRIPTS .. "/system/setup-state.sh")
    exec(HYPRSCRIPTS .. "/system/home-cleaner.sh")

    -- Clean games
    exec(HYPRSCRIPTS .. "/game-mode/cleanup-games.sh")

    -- Setup XDG for screen sharing
    exec(HYPRSCRIPTS .. "/system/xdg.sh")

    -- Start waybar and waypaper
    exec("waypaper --restore")
    exec(HYPRSCRIPTS .. "/waybar/launch.sh")
    exec("hyprsunset -i")

    -- Polkit
    -- Gnome polkit is not supported anymore. If it stops working, switch to hyprpolkitagent.
    -- For now, gnome polkit is just much better.
    -- exec("systemctl --user start hyprpolkitagent")
    exec("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Gnome Keyring
    exec("gnome-keyring-daemon --start --components=secrets,ssh")

    -- Dunst
    exec("dunst")

    -- EWW daemon
    exec("eww daemon")

    -- Hypridle → hyprlock
    exec("hypridle")

    -- Clipboard history
    exec("wl-paste --watch cliphist store")

    -- Restore Game Mode
    exec(HYPRSCRIPTS .. "/game-mode/restore.sh")

    -- Nextcloud
    exec(HYPRLAUNCHERS .. "/nextcloud.sh --background")

    -- VPN status
    exec(HYPRSCRIPTS .. "/vpn/update-status.sh")
end)
