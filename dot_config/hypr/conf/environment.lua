--                  _                                      _
--   ___ _ ____   _(_)_ __ ___  _ __  _ __ ___   ___ _ __ | |_
--  / _ \ '_ \ \ / / | '__/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
-- |  __/ | | \ V /| | | | (_) | | | | | | | | |  __/ | | | |_
--  \___|_| |_|\_/ |_|_|  \___/|_| |_|_| |_| |_|\___|_| |_|\__|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

-- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Set the cursor size for xcursor
hl.env("XCURSOR_SIZE", "40")
hl.env("XCURSOR_THEME", "Vimix-white-cursors")

-- GDK
hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland, x11, *")
hl.env("CLUTTER_BACKEND", "wayland")

-- Disable appimage launcher by default
hl.env("APPIMAGELAUNCHER_DISABLE", "1")

-- Ozone
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Other
hl.env("SDL_VIDEODRIVER", "wayland")
