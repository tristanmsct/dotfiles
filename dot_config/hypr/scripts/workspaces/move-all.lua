--                                       _ _
--  _ __ ___   _____   _____        __ _| | |
-- | '_ ` _ \ / _ \ \ / / _ \_____ / _` | | |
-- | | | | | | (_) \ V /  __/_____| (_| | | |
-- |_| |_| |_|\___/ \_/ \___|      \__,_|_|_|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

return function(target)
    local win = hl.get_active_window()
    local windows = hl.get_windows({ workspace = win.workspace.id})
    if not win then return end

    for _, w in ipairs(windows) do
        local ws_per_monitor = 3
        local relative_target = target + (win.monitor.id * ws_per_monitor)
        hl.dispatch(hl.dsp.window.move({ window = w, workspace = relative_target }))
    end
end
