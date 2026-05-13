--        _ _        __ _             _
--   __ _| | |      / _| | ___   __ _| |_
--  / _` | | |_____| |_| |/ _ \ / _` | __|
-- | (_| | | |_____|  _| | (_) | (_| | |_
--  \__,_|_|_|     |_| |_|\___/ \__,_|\__|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

return function()
    local workspace = hl.get_active_workspace()
    local windows = hl.get_windows()

    -- filter to current workspace
    local ws_windows = {}
    for _, w in ipairs(windows) do
        if w.workspace.id == workspace.id then
            table.insert(ws_windows, w)
        end
    end

    if #ws_windows == 0 then return end

    -- check if all are floating
    local all_float = true
    for _, w in ipairs(ws_windows) do
        if not w.floating then
            all_float = false
            break
        end
    end

    -- toggle
    for _, w in ipairs(ws_windows) do
        if all_float then
            hl.dispatch(hl.dsp.window.float({ action = "off", window = w }))
        else
            hl.dispatch(hl.dsp.window.float({ action = "on", window = w }))
        end
    end
end
