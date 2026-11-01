--                                       _ _
--  _ __ ___   _____   _____        __ _| | |
-- | '_ ` _ \ / _ \ \ / / _ \_____ / _` | | |
-- | | | | | | (_) \ V /  __/_____| (_| | | |
-- |_| |_| |_|\___/ \_/ \___|      \__,_|_|_|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local smw = require("plugins.split-monitor-workspaces")

return function(target)
    -- Script only works with at least one window on the monitor so there must be a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- Getting all windows for the focused workspace.
    local windows = hl.get_windows({ workspace = win.workspace.id})

    -- Moving all windows to the target workspace.
    for _, w in ipairs(windows) do
        -- With only one monitor, win.monitor.id is 0.
        local ws_per_monitor = 3
        local relative_target = target + (win.monitor.id * ws_per_monitor)
        hl.dispatch(hl.dsp.window.move({ window = w, workspace = relative_target }))
    end
end
