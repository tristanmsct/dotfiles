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
local mainMod = "SUPER"
local HYPRSCRIPTS = os.getenv("HOME") .. "/.config/hypr/scripts"
local e = hl.dsp.exec_cmd

local move_all = dofile(HYPRSCRIPTS .. "/workspaces/move-all.lua")

-- Integrated monitor
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-- Base split_monitor_workspaces plugin configuration
hl.config({
    plugin = {
        split_monitor_workspaces = {
            count                        = 5,
            keep_focused                 = 1,
            enable_notifications         = 0,
            enable_persistent_workspaces = 1,
            enable_wrapping              = 1,
            link_monitors                = 0,
        },
    },
})

-- --------------------------------------------------------------------------------------
-- Helper functions
-- --------------------------------------------------------------------------------------
local function has_external_monitor()
    local monitors = hl.get_monitors()
    for _, m in ipairs(monitors) do
        if m.name ~= "eDP-1" then
            return true
        end
    end
    return false
end

local function is_home()
    local monitors = hl.get_monitors()
    for _, m in ipairs(monitors) do
        -- check whichever field matches the description
        if m.description == "Acer Technologies QG241Y TLAEE001854A" then
            return true
        end
    end
    return false
end

local function get_external_monitor()
    local monitors = hl.get_monitors()
    for _, m in ipairs(monitors) do
        if m.name ~= "eDP-1" then
            return m
        end
    end
    return nil
end

local function integrated_monitor_enabled()
    local monitors = hl.get_monitors()
    for _, m in ipairs(monitors) do
        if m.name == "eDP-1" then
            return true
        end
    end
    return false
end

local smw = hl.plugin.split_monitor_workspaces

local last_setup = nil
local function setup_workspaces()
    local current = has_external_monitor() and "external" or "internal"
    if current == last_setup then return end
    last_setup = current

    local ws_keys = {
        { key = "ampersand",  n = 1 },
        { key = "eacute",     n = 2 },
        { key = "quotedbl",   n = 3 },
        { key = "apostrophe", n = 4 },
        { key = "parenleft",  n = 5 },
        { key = "minus",      n = 6 },
        { key = "egrave",     n = 7 },
        { key = "underscore", n = 8 },
        { key = "ccedilla",   n = 9 },
        { key = "agrave",     n = 10 },
    }

    for _, ws in ipairs(ws_keys) do
        hl.unbind(mainMod .. " + " .. ws.key)
        hl.unbind(mainMod .. " + SHIFT + " .. ws.key)
        hl.unbind(mainMod .. " + CTRL + " .. ws.key)
    end

    hl.bind(mainMod .. " + R", function() return smw.grab_rogue_windows() end)
    hl.bind(mainMod .. " + D", function() return smw.change_monitor() end)

    if has_external_monitor() then

        local external = get_external_monitor()
        if is_home() then
            hl.monitor({
                output   = external.name,
                mode     = "1920x1080@120Hz",
                position = "-1920x-600",
                scale    = 1,
            })
        end

        -- Set monitor priority (first entry = lowest workspace numbers)
        smw.monitor_priority({ "eDP-1", external.name })

        -- Set max workspaces per monitor (call once per monitor)
        smw.max_workspaces({ monitor = "eDP-1", max = 3 })
        smw.max_workspaces({ monitor = external.name, max = 3 })

        for _, ws in ipairs(ws_keys) do
            hl.bind(mainMod .. " + " .. ws.key, function() return smw.workspace(ws.n) end, { description = "Go to workspace " .. ws.n })
            hl.bind(mainMod .. " + SHIFT + " .. ws.key, function()
                smw.move_to_workspace_silent(ws.n)
                smw.workspace(ws.n)
            end, { description = "Move active window to workspace " .. ws.n })
            hl.bind(mainMod .. " + CTRL + " .. ws.key, function() return move_all(ws.n) end, { description = "Move all windows to workspace " .. ws.n })
        end
    else
        -- laptop only: normal workspace switching
        smw.max_workspaces({ monitor = "eDP-1", max = 4 })

        for _, ws in ipairs(ws_keys) do
            hl.bind(mainMod .. " + " .. ws.key, hl.dsp.focus({ workspace = ws.n }), { description = "Go to workspace " .. ws.n })
            hl.bind(mainMod .. " + SHIFT + " .. ws.key, hl.dsp.window.move({ workspace = ws.n }), { description = "Move active window to workspace " .. ws.n })
            hl.bind(mainMod .. " + CTRL + " .. ws.key, function() return move_all(ws.n) end, { description = "Move all windows to workspace " .. ws.n })
        end
    end
end

-- --------------------------------------------------------------------------------------
-- Monitor setup
-- --------------------------------------------------------------------------------------
-- run once at startup
setup_workspaces()

-- re-run on monitor changes
hl.on("monitor.layout_changed", function()
    setup_workspaces()
end)

-- Lid switch → hyprlock
hl.bind("switch:on:Lid Switch", function()
  local monitors = hl.get_monitors()
  for _, mon in ipairs(monitors) do
    if mon.name == "eDP-1" then
      hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
      return
    end
  end
end, { locked = true })
