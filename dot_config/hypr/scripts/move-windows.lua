--                                         _           _
--  _ __ ___   _____   _____     __      _(_)_ __   __| | _____      _____
-- | '_ ` _ \ / _ \ \ / / _ \____\ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __|
-- | | | | | | (_) \ V /  __/_____\ V  V /| | | | | (_| | (_) \ V  V /\__ \
-- |_| |_| |_|\___/ \_/ \___|      \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local smw = require("plugins.split-monitor-workspaces")
local M = {}

local function move_to_end()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- Getting all workspaces (including on other monitors and special workspaces).
    local workspaces = hl.get_workspaces()

    local lst_ids = {}
    for _, ws in ipairs(workspaces) do
        if ws.monitor == win.monitor then table.insert(lst_ids, ws.id) end
    end

    local last_workspace = math.max(table.unpack(lst_ids))

    hl.dispatch(hl.dsp.window.move({ workspace = last_workspace, follow = false }))
end

local function move_to_empty()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- Getting all workspaces (including on other monitors and special workspaces).
    local workspaces = hl.get_workspaces()

    local lst_empty_ids = {}
    local lst_ids = {}
    for _, ws in ipairs(workspaces) do
        if ws.monitor == win.monitor and ws.windows == 0 then table.insert(lst_empty_ids, ws.id) end
        if ws.monitor == win.monitor then table.insert(lst_ids, ws.id) end
    end

    local next_empty = #lst_empty_ids > 0 and math.min(table.unpack(lst_empty_ids)) or math.max(table.unpack(lst_ids))

    -- The distinction is important because with one monitor, we need to be able to go beyond the smw max monitor count
    if #hl.get_monitors() == 1 then
        hl.dispatch(hl.dsp.window.move({ workspace = next_empty, follow = false }))
    else
        hl.dispatch(smw.move_to_workspace_silent(next_empty))
    end
end

local function move_all(target)
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

local function switch_monitor()
    -- Script only works with a focused window.
    local win = hl.get_active_window()
    if not win then return end

    -- This convoluted garbage is because monitor id can be a bit random, eDP-1 can be 0 and then the only other monitor can be 2.
    local lst_monitors = hl.get_monitors()
    local next_monitors_active_workspace = lst_monitors[1].active_workspace.id
    local past_current_monitor = false

    for i, m in ipairs(lst_monitors) do
        if past_current_monitor then
            next_monitors_active_workspace = lst_monitors[i].active_workspace.id
            break
        end
        if m.id == win.monitor.id then past_current_monitor = true end
    end

    hl.dispatch(hl.dsp.window.move({ workspace = next_monitors_active_workspace, follow = true }))
end

local function compact_workspaces()
    local monitors = hl.get_monitors()
    hl.dispatch(hl.dsp.exec_cmd("dunstify hey"))

    local windows = hl.get_windows()

    for _, w in ipairs(windows) do
        hl.dispatch(hl.dsp.window.move({ window = w, workspace = 1 }))
    end
end

-- This is the Lua equivalent of the Python compaction logic.
-- It groups workspaces by monitor-sized blocks of 3 and remaps each occupied
-- workspace to the first available slot in that block. This makes the workspace
-- layout more compact without reordering monitor assignments.
local function create_workspace_mappings(non_empty_workspaces)
    local workspace_per_monitor = 3
    local monitor_count = #hl.get_monitors()

    local max_workspace = 0
    for _, ws_id in ipairs(non_empty_workspaces) do
        if ws_id > max_workspace then
            max_workspace = ws_id
        end
    end

    local nb_threshold_above = math.floor(max_workspace / workspace_per_monitor) + 1
    local mappings = {}

    for threshold = 1, nb_threshold_above do
        local min_workspace = workspace_per_monitor * (threshold - 1)
        local max_workspace_in_threshold = workspace_per_monitor * threshold
        local workspaces_in_threshold = {}

        for _, ws_id in ipairs(non_empty_workspaces) do
            if threshold < monitor_count then
                if min_workspace < ws_id and ws_id <= max_workspace_in_threshold then
                    table.insert(workspaces_in_threshold, ws_id)
                end
            else
                if min_workspace < ws_id then
                    table.insert(workspaces_in_threshold, ws_id)
                end
            end
        end

        table.sort(workspaces_in_threshold)

        local previous_target = 0
        for _, ws_id in ipairs(workspaces_in_threshold) do
            local target = math.max(previous_target + 1, min_workspace + 1)
            mappings[ws_id] = target
            previous_target = target
        end

        if threshold == monitor_count then
            break
        end
    end

    return mappings
end

local function compact_workspaces()
    local windows = hl.get_windows()
    local non_empty_workspaces = {}
    local seen = {}

    for _, win in ipairs(windows) do
        if win.workspace and win.workspace.type ~= "special" then
            local workspace_id = win.workspace.id
            if not seen[workspace_id] then
                seen[workspace_id] = true
                table.insert(non_empty_workspaces, workspace_id)
            end
        end
    end

    table.sort(non_empty_workspaces)
    local workspace_mapping = create_workspace_mappings(non_empty_workspaces)

    for _, ws_id in ipairs(non_empty_workspaces) do
        local target_workspace = workspace_mapping[ws_id]
        if target_workspace and target_workspace ~= ws_id then
            local windows_to_move = {}
            for _, win in ipairs(windows) do
                if win.workspace and win.workspace.id == ws_id then
                    table.insert(windows_to_move, win)
                end
            end

            for _, win in ipairs(windows_to_move) do
                hl.dispatch(hl.dsp.window.move({
                    window = win,
                    workspace = target_workspace,
                    follow = false,
                }))
            end
        end
    end
end

M.move_to_end = move_to_end
M.move_to_empty = move_to_empty
M.move_all = move_all
M.switch_monitor = switch_monitor
M.compact_workspaces = compact_workspaces
M.compact_workspaces = compact_workspaces

return M
