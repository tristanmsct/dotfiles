--                                 _                                   _
--  _ __ ___   _____   _____      | |_ ___         ___ _ __ ___  _ __ | |_ _   _
-- | '_ ` _ \ / _ \ \ / / _ \_____| __/ _ \ _____ / _ \ '_ ` _ \| '_ \| __| | | |
-- | | | | | | (_) \ V /  __/_____| || (_) |_____|  __/ | | | | | |_) | |_| |_| |
-- |_| |_| |_|\___/ \_/ \___|      \__\___/       \___|_| |_| |_| .__/ \__|\__, |
--                                                              |_|        |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local smw = hl.plugin.split_monitor_workspaces

return function()
  local win = hl.get_active_window()
  if not win then return end
  local workspaces = hl.get_workspaces()
  local monitor = win.monitor

  local empty, last = nil, nil

  for _, ws in ipairs(workspaces) do
    if ws.monitor == monitor then
      if not last or ws.id > last.id then last = ws end
      if ws.windows == 0 and (not empty or ws.id < empty.id) then empty = ws end
    end
  end

  local target = empty and empty.id or last.id

  local monitors = hl.get_monitors()
  local has_external = false
  for _, m in ipairs(monitors) do
    if m.name ~= "eDP-1" then has_external = true end
  end

  if has_external then
    local ws_per_monitor = 3
    local relative_target = target - (win.monitor.id * ws_per_monitor)
    smw.move_to_workspace_silent(relative_target)
  else
    hl.dsp.window.move({ workspace = target })
  end
end
