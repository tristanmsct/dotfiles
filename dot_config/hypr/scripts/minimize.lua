--            _       _           _
--  _ __ ___ (_)_ __ (_)_ __ ___ (_)_______
-- | '_ ` _ \| | '_ \| | '_ ` _ \| |_  / _ \
-- | | | | | | | | | | | | | | | | |/ /  __/
-- |_| |_| |_|_|_| |_|_|_| |_| |_|_/___\___|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local function swap_minimized()
    if hl.get_workspace("special:minimized") then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
    else
        hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    end
end

local function send_to_minimized()
    hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
end

local function get_from_minimized()
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
    hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
end

local M = {}
M.swap_minimized = swap_minimized
M.send_to_minimized = send_to_minimized
M.get_from_minimized = get_from_minimized

return M
