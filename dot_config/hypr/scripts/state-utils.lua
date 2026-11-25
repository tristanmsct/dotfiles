--      _        _                   _   _ _
--  ___| |_ __ _| |_ ___       _   _| |_(_) |___
-- / __| __/ _` | __/ _ \_____| | | | __| | / __|
-- \__ \ || (_| | ||  __/_____| |_| | |_| | \__ \
-- |___/\__\__,_|\__\___|      \__,_|\__|_|_|___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local cjson = require("cjson")
local M = {}

local function path()
    local dir = os.getenv("DESKTOP_STATE_DIR") or os.getenv("XDG_RUNTIME_DIR")
    return dir and (dir .. "/state.json") or nil
end

function M.load()
    local p = path()
    local f = p and io.open(p, "r")
    if not f then return {} end
    local raw = f:read("*a")
    f:close()
    local ok, data = pcall(cjson.decode, raw)
    return (ok and type(data) == "table") and data or {}
end

function M.save(state)
    local p = path()
    if not p then return end
    local tmp = p .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then return end
    f:write(cjson.encode(state))
    f:close()
    os.rename(tmp, p) -- atomic, no half-written file
end

function M.get(section, key)
    local s = M.load()[section]
    return s and s[key] or nil
end

function M.set(section, key, value) -- value nil removes the key
    local state = M.load()
    state[section] = state[section] or {}
    state[section][key] = value
    M.save(state)
end

return M
