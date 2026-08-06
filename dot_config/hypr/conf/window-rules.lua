--           _           _                            _
-- __      _(_)_ __   __| | _____      __  _ __ _   _| | ___  ___
-- \ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / | '__| | | | |/ _ \/ __|
--  \ V  V /| | | | | (_| | (_) \ V  V /  | |  | |_| | |  __/\__ \
--   \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/   |_|   \__,_|_|\___||___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

-- Generic: no border on floating
hl.window_rule({
    name  = "no-border-on-floating",
    match = { float = true },
    border_size = 0,
})

-- Brave
hl.window_rule({
    name  = "brave",
    match = { class = "^([Bb]rave-browser)$" },
    opaque = true,
})

-- Picture in Picture
hl.window_rule({
    name  = "picture-in-picture",
    match = { title = "^([Pp]icture[\\s\\-]in[\\s\\-][Pp]icture)$" },
    float = true,
    pin   = true,
    size  = "900 500",
    move  = "600 400",
})

-- Pavucontrol
hl.window_rule({
    name  = "pavucontrol",
    match = { class = ".*org.pulseaudio.pavucontrol.*" },
    float  = true,
    size   = "monitor_w*0.4 monitor_h*0.5",
    center = true,
    pin    = true,
})

-- Waypaper
hl.window_rule({
    name  = "waypaper",
    match = { class = ".*waypaper.*" },
    float  = true,
    size   = "monitor_w*0.4 monitor_h*0.65",
    center = true,
    pin    = true,
})

-- System update
hl.window_rule({
    name  = "systemupdate",
    match = { title = "systemupdate" },
    float  = true,
    size   = "900 600",
    center = true,
})

-- Sushi (Nautilus previewer)
hl.window_rule({
    name  = "sushi",
    match = { class = "org.gnome.NautilusPreviewer" },
    float  = true,
    size   = "1300 900",
    center = true,
})

-- Gnome Calculator
hl.window_rule({
    name  = "gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    float  = true,
    size   = "700 600",
    center = true,
})

-- Gnome Calendar
hl.window_rule({
    name  = "gnome-calendar",
    match = { class = "org.gnome.Calendar" },
    float = true,
    size  = "monitor_w*0.3 monitor_h*0.4",
    move  = "(monitor_w/2)-window_w/2 monitor_h*0.15",
})

-- Gnome Weather
hl.window_rule({
    name  = "gnome-weather",
    match = { class = "org.gnome.Weather" },
    float = true,
    size  = "monitor_w*0.55 monitor_h*0.65",
    move  = "(monitor_w/4)-window_w/2 monitor_h*0.15",
})

-- Smile emoji picker
hl.window_rule({
    name  = "smile",
    match = { class = "it.mijorus.smile" },
    float = true,
    pin   = true,
    size  = "500 600",
    move  = "1300 100",
})

-- Nextcloud
hl.window_rule({
    name  = "nextcloud",
    match = { title = "^(Nextcloud)$" },
    float = true,
    size  = "700 800",
    move  = "1200 70",
})

hl.window_rule({
    name  = "nextcloud-settings",
    match = { title = "^(Nextcloud Settings)$" },
    float = true,
    size  = "950 800",
    move  = "920 100",
})

-- Adw-bluetooth
hl.window_rule({
    name  = "adw-bluetooth",
    match = { class = "^(.*AdwBluetooth)$" },
    float  = true,
    size   = "500 650",
    center = true,
})

-- Network Manager RS
hl.window_rule({
    name  = "network-manager-gui",
    match = { class = "^(org.nmrs.ui)$" },
    float  = true,
    size   = "500 650",
    center = true,
})

-- NMTUI
hl.window_rule({
    name  = "network-manager",
    match = { class = "^(nmtui)$" },
    float  = true,
    size   = "1000 700",
    center = true,
})

-- Network password utility
hl.window_rule({
    name  = "networkpwd",
    match = { class = "^(networkpwd)$" },
    float  = true,
    size   = "600 600",
    center = true,
})

-- Localsend
hl.window_rule({
    name  = "localsend",
    match = { title = "LocalSend" },
    float  = true,
    size   = "700 800",
    center = true,
})

-- Steam payment page
hl.window_rule({
    name  = "steam",
    match = { initial_title = "^SteamWebhelper$" },
    float  = true,
    size   = "500 650",
    center = true,
})

-- Bitwarden (Brave PWA)
hl.window_rule({
    name  = "bitwarden",
    match = { class = "^(brave-nn.*-Default)$" },
    float = true,
    size  = "500 700",
    move  = "1400 70",
})

-- MPV / Celluloid
hl.window_rule({
    name  = "mpv-celluloid",
    match = { initial_class = "io.github.celluloid_player.Celluloid" },
    opaque = true,
})

-- VLC
hl.window_rule({
    match  = { class = "^(vlc)$" },
    opaque = true,
})
hl.window_rule({
    name  = "vlc-timestamp",
    match = { initial_title = "vlc" },
    rounding = 0,
})

-- Meld
hl.window_rule({
    name  = "meld-float",
    match = { class = "org.gnome.Meld" },
    float  = true,
    size   = "1400 900",
    center = true,
})

-- PCSX2
hl.window_rule({
    name  = "pcsx2",
    match = { title = "PCSX2 Settings" },
    float  = true,
    size   = "1000 700",
    center = true,
})

-- Mission Center
hl.window_rule({
    match  = { class = "io.missioncenter.MissionCenter" },
    opaque = true,
})

-- File/directory picker
hl.window_rule({
    name  = "file-picker",
    match = { tag = "filepicker" },
    float  = true,
    size   = "1000 700",
    center = true,
})

hl.window_rule({ match = { initial_title = "^(Select Folder)$|^(Select File)$|^(Open Folder)$|^(Open File)$|^(Save File)$|^(Save As)$" }, tag = "+filepicker" })
hl.window_rule({ match = { title       = "^(Select Folder)$|^(Select File)$|^(Open Folder)$|^(Open File)$|^(Save File)$|^(Save As)$" }, tag = "+filepicker" })
hl.window_rule({ match = { class       = "^(xdg-desktop-portal-gtk)$" }, tag = "+filepicker" })

-- OnlyOffice save dialog
hl.window_rule({
    name  = "onlyoffice-save",
    match = { initial_class = "DesktopEditors" },
    float  = true,
    center = true,
})
