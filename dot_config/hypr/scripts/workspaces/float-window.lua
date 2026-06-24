--   __ _             _                _           _
--  / _| | ___   __ _| |_    __      _(_)_ __   __| | _____      __
-- | |_| |/ _ \ / _` | __|___\ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / /
-- |  _| | (_) | (_| | ||_____\ V  V /| | | | | (_| | (_) \ V  V /
-- |_| |_|\___/ \__,_|\__|     \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

return function()
    local w = hl.get_active_window()

    if w.floating then
        hl.dispatch(hl.dsp.window.float({ action = "tile" }))
    else
        local windows = hl.get_windows()
        local float_count = 0
        for _, win in ipairs(windows) do
            if win.floating then float_count = float_count + 1 end
        end
            local offset = float_count * 20
            hl.dispatch(hl.dsp.window.float({ action = "on", window = w }))
            hl.dispatch(hl.dsp.window.resize({ window = w, x = 1100, y = 700 }))
            hl.dispatch(hl.dsp.window.move({ window = w, x = 100 + offset, y = 100 + offset }))
    end
end
