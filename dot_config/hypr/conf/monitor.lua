--                        _ _
--  _ __ ___   ___  _ __ (_) |_ ___  _ __
-- | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
-- | | | | | | (_) | | | | | || (_) | |
-- |_| |_| |_|\___/|_| |_|_|\__\___/|_|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
-- Base setup
-- --------------------------------------------------------------------------------------
local smw = require("plugins.split-monitor-workspaces")

-- Base split_monitor_workspaces plugin configuration.
smw.setup({
    keep_focused                 = true,
    enable_notifications         = false,
    enable_persistent_workspaces = true,
    enable_wrapping              = true,
    link_monitors                = false
})

-- --------------------------------------------------------------------------------------
-- Helper functions
-- --------------------------------------------------------------------------------------
local function reset_integrated_monitor()
    hl.monitor({
        output   = "eDP-1",
        disabled = false
    })
end

local function profile_path()
    local dir = os.getenv("DESKTOP_STATE_DIR")
    return dir and (dir .. "/monitor_profile") or nil
end

local function read_last_profile()
    local path = profile_path()
    if not path then return nil end

    local f = io.open(path, "r")
    if not f then return nil end

    local content = f:read("*l")
    f:close()
    return content
end

local function write_last_profile(profile)
    local path = profile_path()
    if not path then return end

    local f = io.open(path, "w")
    if f then
        f:write(profile)
        f:close()
    end
end

local function detect_profile()
    local monitors = hl.get_monitors()
    local has_internal = false
    local has_external = false
    local has_home_monitor = false

    for _, m in ipairs(monitors) do
        if m.name == "FALLBACK" then
            return "fallback"
        elseif m.name == "eDP-1" then
            has_internal = true
        else
            has_external = true
        end

        if m.description and m.description == "Acer Technologies QG241Y TLAEE001854A" then
            has_home_monitor = true
        end
    end

    if has_internal and not (has_external) then
        return "laptop"
    end

    if has_internal and has_home_monitor then
        return "home_dock"
    end

    if has_external and not has_internal then
        return "external_only"
    end

    return "other"
end

local function setup_laptop_mode()
    hl.monitor({
        output   = "eDP-1",
        mode     = "preferred",
        position = "auto",
        scale    = 1,
        bitdepth = 10,
        supports_wide_color = -1,
    })

    smw.setup({
        monitor_priority = { "eDP-1" },
        max_workspaces =   { ["eDP-1"] = 4 }
    })
end

local function setup_home_dock_mode()
    local home_monitor = "desc:Acer Technologies QG241Y TLAEE001854A"
    hl.monitor({
        output   = "eDP-1",
        mode     = "preferred",
        position = "0x0",
        scale    = 1,
        supports_wide_color = -1,
    })
    hl.monitor({
        output   = home_monitor,
        mode     = "1920x1080@120Hz",
        position = "-1920x-600",
        supports_wide_color = -1,
    })

    smw.setup({
        monitor_priority = { "eDP-1", home_monitor },
        max_workspaces =   { ["eDP-1"] = 3, [home_monitor] = 3 }
    })
end

local function setup_external_only_mode()
    local monitors = hl.get_monitors()
    local priority = {}
    local max_workspaces = {}

    hl.monitor({
        output   = "eDP-1",
        disabled = true,
    })

    -- apply the same safe default to all external monitors.
    for _, mon in ipairs(monitors) do
        if mon.name ~= "eDP-1" then
            table.insert(priority, mon.name)
            max_workspaces[mon.name] = 3

            hl.monitor({
                output   = mon.name,
                mode     = "preferred",
                position = "auto",
            })
        end
    end

    smw.setup({
        monitor_priority = priority,
        max_workspaces = max_workspaces
    })
end

local function setup_default_multi_monitor_mode()
    local monitors = hl.get_monitors()
    local priority = { "eDP-1" }
    local max_workspaces = { ["eDP-1"] = 3 }

    -- keep the internal monitor in its usual place.
    hl.monitor({
        output   = "eDP-1",
        scale    = 1,
        supports_wide_color = -1,
    })

    -- apply the same safe default to all external monitors.
    for _, mon in ipairs(monitors) do
        if mon.name ~= "eDP-1" then
            table.insert(priority, mon.name)
            max_workspaces[mon.name] = 3

            hl.monitor({
                output   = mon.name,
                supports_wide_color = -1,
            })
        end
    end

    smw.setup({
        monitor_priority = priority,
        max_workspaces   = max_workspaces
    })
end

local function setup_workspaces()
    local profile = detect_profile()

    if profile == "fallback" then
        reset_integrated_monitor()
    elseif profile == "laptop" then
        setup_laptop_mode()
    elseif profile == "home_dock" then
        setup_home_dock_mode()
    elseif profile == "external_only" then
        setup_external_only_mode()
    else
        setup_default_multi_monitor_mode()
    end
end

-- --------------------------------------------------------------------------------------
-- Monitor setup
-- --------------------------------------------------------------------------------------
-- run once at startup.
write_last_profile(detect_profile())
setup_workspaces()

-- re-run on monitor changes.
hl.on("monitor.layout_changed", function()
    local profile = detect_profile()
    if profile ~= read_last_profile() then
        write_last_profile(profile)
        setup_workspaces()
        hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    end
end)

-- So new monitor get the new wallpaper. No need to do it on remove.
hl.on("monitor.added", function()
    hl.dispatch(hl.dsp.exec_cmd("waypaper --restore"))
end)
