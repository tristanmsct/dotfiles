--            _
--  _ __ ___ (_)___  ___
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__
-- |_| |_| |_|_|___/\___|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local function close_lid()
    local monitors = hl.get_monitors()
    for _, mon in ipairs(monitors) do
        if mon.name == "eDP-1" then
            hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
            return
        end
    end
end

local M = {}
M.close_lid = close_lid

return M
