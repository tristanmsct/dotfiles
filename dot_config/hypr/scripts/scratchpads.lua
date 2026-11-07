--                     _       _                     _
--  ___  ___ _ __ __ _| |_ ___| |__  _ __   __ _  __| |___
-- / __|/ __| '__/ _` | __/ __| '_ \| '_ \ / _` |/ _` / __|
-- \__ \ (__| | | (_| | || (__| | | | |_) | (_| | (_| \__ \
-- |___/\___|_|  \__,_|\__\___|_| |_| .__/ \__,_|\__,_|___/
--                                  |_|
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local KITTY_TAG = "scratchpad-kitty"
local M = {}

local function has_tag(w, tag)
  local t, list = w.tags, {}
  if type(t) == "table" then
    list = t
  elseif type(t) == "string" then
    for s in t:gmatch("[^,%s]+") do list[#list + 1] = s end
  end
  for _, v in ipairs(list) do
    if (tostring(v):gsub("%*$", "")) == tag then return true end
  end
  return false
end

local function find_scratch(tag)
  for _, w in ipairs(hl.get_windows()) do
    if has_tag(w, tag) then return w end
  end
end

local function scratch_kitty()
  local w = find_scratch(KITTY_TAG)

  if not w then
    hl.dispatch(hl.dsp.exec_cmd("kitty", {
      float  = true,
      pin    = true,
      -- center = true,
      size   = { 1000, 650 },
      move = "900 100",
        tag    = "+" .. KITTY_TAG,
    }))
    return
  end

  if w.workspace and w.workspace.name == "special:" .. KITTY_TAG then
    hl.dispatch(hl.dsp.window.pin({window = w}))
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = w }))
    hl.dispatch(hl.dsp.focus({ window = w }))
  else
    hl.dispatch(hl.dsp.window.pin({window = w}))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:" .. KITTY_TAG, follow = false, window = w }))
  end
end

M.scratch_kitty = scratch_kitty

return M
