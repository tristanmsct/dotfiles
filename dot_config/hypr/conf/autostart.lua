--              _            _             _
--   __ _ _   _| |_ ___  ___| |_ __ _ _ __| |_
--  / _` | | | | __/ _ \/ __| __/ _` | '__| __|
-- | (_| | |_| | || (_) \__ \ || (_| | |  | |_
--  \__,_|\__,_|\__\___/|___/\__\__,_|_|   \__|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local SCRIPTS = os.getenv("DESKTOP_SCRIPTS")
local USERSCRIPTS   = os.getenv("HOME") .. "/.local/bin"

hl.on("hyprland.start", function()
    local function exec(cmd)
        hl.dispatch(hl.dsp.exec_cmd(cmd))
    end

    -- For IIO
    exec("iio-hyprland")

    -- Clean Home Directory / Set up state
    exec(SCRIPTS .. "/system/setup-state.sh")
    exec(SCRIPTS .. "/system/home-cleaner.sh")

    -- Clean games
    exec(SCRIPTS .. "/system/cleanup-games.sh")

    -- Setup XDG for screen sharing
    -- TODO : remove if possible
    -- exec(SCRIPTS .. "/system/xdg.sh")

    -- Start waybar and waypaper
    exec("waypaper --restore")
    exec(SCRIPTS .. "/waybar/launch.sh")
    -- TODO : is this necessary ?
    -- exec("hyprsunset -i")

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
    exec(SCRIPTS .. "/focus-mode/restore.sh")

    -- Nextcloud
    exec(USERSCRIPTS .. "/nextcloud --background")

    -- VPN status
    exec(SCRIPTS .. "/vpn/update-status.sh")
end)
