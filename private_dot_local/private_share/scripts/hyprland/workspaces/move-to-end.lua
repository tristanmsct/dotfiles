--                                 _                             _
--  _ __ ___   _____   _____      | |_ ___         ___ _ __   __| |
-- | '_ ` _ \ / _ \ \ / / _ \_____| __/ _ \ _____ / _ \ '_ \ / _` |
-- | | | | | | (_) \ V /  __/_____| || (_) |_____|  __/ | | | (_| |
-- |_| |_| |_|\___/ \_/ \___|      \__\___/       \___|_| |_|\__,_|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local smw = require("plugins.split-monitor-workspaces")

return function()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- Getting all workspaces (including on other monitors and special workspaces).
    local workspaces = hl.get_workspaces()

    local lst_ids = {}
    for _, ws in ipairs(workspaces) do
        if ws.monitor == win.monitor then table.insert(lst_ids, ws.id) end
    end

    local last_workspace = math.max(table.unpack(lst_ids))

    hl.dispatch(hl.dsp.exec_cmd("dunstify " .. last_workspace))

    -- The distinction is important because with one monitor, we need to be able to go beyond the smw max monitor count
    if #hl.get_monitors() == 1 then
        hl.dispatch(hl.dsp.window.move({ workspace = last_workspace, follow = false }))
    else
        hl.dispatch(smw.move_to_workspace_silent(last_workspace))
    end
end
