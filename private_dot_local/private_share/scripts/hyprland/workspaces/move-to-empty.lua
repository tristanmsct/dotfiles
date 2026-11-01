--                                 _                                   _
--  _ __ ___   _____   _____      | |_ ___         ___ _ __ ___  _ __ | |_ _   _
-- | '_ ` _ \ / _ \ \ / / _ \_____| __/ _ \ _____ / _ \ '_ ` _ \| '_ \| __| | | |
-- | | | | | | (_) \ V /  __/_____| || (_) |_____|  __/ | | | | | |_) | |_| |_| |
-- |_| |_| |_|\___/ \_/ \___|      \__\___/       \___|_| |_| |_| .__/ \__|\__, |
--                                                              |_|        |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local smw = require("plugins.split-monitor-workspaces")

return function()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- Getting all workspaces (including on other monitors and special workspaces).
    local workspaces = hl.get_workspaces()

    local lst_empty_ids = {}
    local lst_ids = {}
    for _, ws in ipairs(workspaces) do
        if ws.monitor == win.monitor and ws.windows == 0 then table.insert(lst_empty_ids, ws.id) end
        if ws.monitor == win.monitor then table.insert(lst_ids, ws.id) end
    end

    local next_empty = #lst_empty_ids > 0 and math.min(table.unpack(lst_empty_ids)) or math.max(table.unpack(lst_ids))

    -- The distinction is important because with one monitor, we need to be able to go beyond the smw max monitor count
    if #hl.get_monitors() == 1 then
        hl.dispatch(hl.dsp.window.move({ workspace = next_empty, follow = false }))
    else
        hl.dispatch(smw.move_to_workspace_silent(next_empty))
    end
end
