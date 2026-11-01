--       _                                                        _ _
--   ___| |__   __ _ _ __   __ _  ___       _ __ ___   ___  _ __ (_) |_ ___  _ __
--  / __| '_ \ / _` | '_ \ / _` |/ _ \_____| '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
-- | (__| | | | (_| | | | | (_| |  __/_____| | | | | | (_) | | | | | || (_) | |
--  \___|_| |_|\__,_|_| |_|\__, |\___|     |_| |_| |_|\___/|_| |_|_|\__\___/|_|
--                         |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

return function()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- This convoluted garbage is because monitor id can be a bit random, eDP-1 can be 0 and then the only other monitor can be 2.
    local lst_monitors = hl.get_monitors()
    local next_monitors_active_workspace = lst_monitors[1].active_workspace.id
    local past_current_monitor = false

    for i, m in ipairs(lst_monitors) do
        if past_current_monitor then
            next_monitors_active_workspace = lst_monitors[i].active_workspace.id
            break
        end
        if m.id == win.monitor.id then past_current_monitor = true end
    end

    hl.dispatch(hl.dsp.window.move({ workspace = next_monitors_active_workspace, follow = true }))
end
