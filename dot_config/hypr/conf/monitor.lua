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
local profiles = require("scripts.monitor-utils")
local smw = require("plugins.split-monitor-workspaces")
local state = require("scripts.state-utils")

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
local function set_integrated_monitor()
    local s = profiles.MONITORS.internal
    hl.monitor({
        output              = s.name,
        disabled            = false,
        mode                = s.mode,
        position            = s.position,
        scale               = s.scale,
        bitdepth            = s.bitdepth,
        supports_wide_color = -1,
    })
end

local function setup_monitors(profile)
    local external_only = profile == "external_only"
    local mirror        = profile == "mirror"
    local priority, max_workspaces = {}, {}

    if external_only then
        hl.monitor({ output = "eDP-1", disabled = true })
    else
        set_integrated_monitor()
        table.insert(priority, "eDP-1")
        max_workspaces["eDP-1"] = 3
    end

    for _, mon in ipairs(hl.get_monitors({ all = true })) do
        if mon.name ~= "eDP-1" then
            if mirror then
                hl.monitor({ output = mon.name, mirror = "eDP-1" })
            else
                local s = profiles.settings_for(mon)
                local opts = {
                    output              = mon.name,
                    mode                = s.mode,
                    scale               = s.scale,
                    position            = external_only and "auto" or s.position,
                    supports_wide_color = -1,
                }
                table.insert(priority, mon.name)
                max_workspaces[mon.name] = 3
                hl.monitor(opts)
            end
        end
    end

    if #priority == 1 then
        max_workspaces[priority[1]] = 4
    end

    smw.setup({ monitor_priority = priority, max_workspaces = max_workspaces })
end

local function setup_workspaces(profile)
    if profile == "fallback" then
        set_integrated_monitor()
        state.set("monitor", "pref", "extend")
    else
        setup_monitors(profile)
    end
end

local function current_profile()
    local hw = profiles.detect(hl.get_monitors(), hl.get_monitors({ all = true }))
    return profiles.resolve(hw, state.get("monitor", "pref") or "auto")
end

local function apply(profile)
    state.set("monitor", "applied", profile)
    setup_workspaces(profile)
end

-- --------------------------------------------------------------------------------------
-- Monitor setup
-- --------------------------------------------------------------------------------------
local prev = state.get("monitor", "applied")
local profile = current_profile()
if profile ~= prev then state.set("monitor", "settle", true) end
apply(profile)

hl.on("monitor.layout_changed", function()
    local profile = current_profile()
    if profile ~= state.get("monitor", "applied") then
        apply(profile)
        hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    elseif state.get("monitor", "settle") then
        state.set("monitor", "settle", nil)
        hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    end
    hl.dispatch(hl.dsp.exec_cmd(os.getenv("XDG_CONFIG_HOME") .. "/wallust/scripts/change-hyprlock-target"))
end)

-- So new monitor get the new wallpaper. No need to do it on remove.
hl.on("monitor.added", function()
    hl.dispatch(hl.dsp.exec_cmd("waypaper --restore"))
end)
