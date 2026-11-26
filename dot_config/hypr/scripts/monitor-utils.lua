--                        _ _                        _   _ _
--  _ __ ___   ___  _ __ (_) |_ ___  _ __      _   _| |_(_) |___
-- | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|____| | | | __| | / __|
-- | | | | | | (_) | | | | | || (_) | | |_____| |_| | |_| | \__ \
-- |_| |_| |_|\___/|_| |_|_|\__\___/|_|        \__,_|\__|_|_|___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local M = {}

M.MONITORS = {
    internal = {
        name     = "eDP-1",
        desc     = "Samsung Display Corp. 0x4156",
        mode     = "preferred",
        scale    = 1,
        position = "0x0",
        bitdepth = 10,
    },
    home = {
        desc     = "Acer Technologies QG241Y TLAEE001854A",
        profile  = "home_dock",
        mode     = "1920x1080@120Hz",
        scale    = 1,
        position = "-1920x-600",
    },
    tv = {
        desc     = "Samsung Electric Company SAMSUNG 0x01000E00",
        profile  = "home_tv",
        mode     = "3840x2160@60Hz",
        scale    = 2,
        position = "-1920x0",
    },
    default = { mode = "preferred", scale = 1, position = "auto" },
}

function M.find(monitor)
    if not monitor.description then return nil end
    for key, entry in pairs(M.MONITORS) do
        if key ~= "default" and entry.desc == monitor.description then
            return entry
        end
    end
    return nil
end

function M.settings_for(monitor)
    return M.find(monitor) or M.MONITORS.default
end

-- Pure function: takes a list of monitors, returns a profile name.
function M.detect(active, all)
    for _, m in ipairs(active) do
        if m.name == "FALLBACK" then return "fallback" end
    end

    local has_internal, has_external = false, false
    for _, m in ipairs(active) do
        if m.name == M.MONITORS.internal.name then has_internal = true end
    end
    for _, m in ipairs(all) do
        if m.name ~= M.MONITORS.internal.name and m.name ~= "FALLBACK" then
            has_external = true
        end
    end

    if has_internal and has_external then return "docked" end
    if has_internal then return "laptop" end
    if has_external then return "external_only" end
    return "fallback"
end

function M.resolve(hw, pref)
    if hw == "laptop" or hw == "fallback" then return hw end
    if pref == "mirror"   then return "mirror" end
    if pref == "external" then return "external_only" end
    if pref == "extend"   then return "docked" end
    return hw
end

function M.close_lid()
    local monitors = hl.get_monitors()
    for _, mon in ipairs(monitors) do
        if mon.name == "eDP-1" then
            hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
            return
        end
    end
end

return M
