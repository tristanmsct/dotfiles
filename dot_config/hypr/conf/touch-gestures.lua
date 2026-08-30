--  _                   _                           _
-- | |_ ___  _   _  ___| |__         __ _  ___  ___| |_ _   _ _ __ ___  ___
-- | __/ _ \| | | |/ __| '_ \ _____ / _` |/ _ \/ __| __| | | | '__/ _ \/ __|
-- | || (_) | |_| | (__| | | |_____| (_| |  __/\__ \ |_| |_| | | |  __/\__ \
--  \__\___/ \__,_|\___|_| |_|      \__, |\___||___/\__|\__,_|_|  \___||___/
--                                  |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

local toggle_float_window = dofile(os.getenv("DESKTOP_SCRIPTS") .. "/hyprland/workspaces/float-window.lua")

-- Most workspace_swipe_* options removed in 0.55 — no equivalent in new gesture system
-- workspace_swipe_distance, workspace_swipe_invert, workspace_swipe_min_speed_to_force,
-- workspace_swipe_cancel_ratio, workspace_swipe_forever, workspace_swipe_direction_lock
-- are not available. workspace_swipe_create_new may still exist under gestures config.

hl.config({
    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_cancel_ratio = 0.15,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up",         action = toggle_float_window })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SUPER", action = "resize" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "SHIFT", action = "move" })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })

hl.gesture({ fingers = 4, direction = "up", action = function() hl.exec_cmd("kitty") end })
hl.gesture({ fingers = 4, direction = "down", action = function() hl.exec_cmd("pkill rofi || rofi -show drun -replace -i -disable-history") end })


-- Hyprgrass config for touch screen gestures
-- hl.config({
--     plugin = {
--         hyprgrass = {
--             -- The default sensitivity is probably too low on tablet screens,
--             -- I recommend turning it up to 4.0
--             sensitivity = 1.0,

--             -- in milliseconds
--             long_press_delay = 400,

--             -- resize windows by long-pressing on window borders and gaps.
--             -- If general:resize_on_border is enabled, general:extend_border_grab_area is
--             -- used for floating windows
--             resize_on_border_long_press = true,

--             -- in pixels, the distance from the edge that is considered an edge
--             edge_margin = 10,
--         }
--     }
-- })


-- hl.plugin.hyprgrass.gesture {
--     pattern = {kind = "swipe", fingers = 3, direction = "down"},
--     action = "close",
-- }

-- hl.plugin.hyprgrass.gesture {
--     pattern = {kind = "swipe", fingers = 2, origin = "up", direction = "down"},
--     action = "special",
--     workspace_name = "minimize",
-- }

-- hl.plugin.hyprgrass.bind {
--     pattern = {kind = "swipe", fingers = 2, origin = "down", direction = "up"},
--     action = hl.dsp.exec_cmd("nwg-drawer"),
-- }
