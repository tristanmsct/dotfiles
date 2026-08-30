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

    local ws_windows = {}
    for _, w in ipairs(windows) do
        if w.workspace.id == workspace.id then
            table.insert(ws_windows, w)
        end
    end

    if #ws_windows == 0 then return end

    local all_float = true
    for _, w in ipairs(ws_windows) do
        if not w.floating then all_float = false; break end
    end

    if all_float then
        for _, w in ipairs(ws_windows) do
            hl.dispatch(hl.dsp.window.float({ action = "off", window = w }))
        end
    else
        local float_count = 0
        for _, w in ipairs(ws_windows) do
            if not w.floating then
                local offset = float_count * 20
                hl.dispatch(hl.dsp.window.float({ action = "on", window = w }))
                hl.dispatch(hl.dsp.window.resize({ window = w, x = 1100, y = 700 }))
                hl.dispatch(hl.dsp.window.move({ window = w, x = 100 + offset, y = 100 + offset }))
                float_count = float_count + 1
            end
        end
    end
end
