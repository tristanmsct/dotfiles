--      _                          _   _
--   __| | ___  ___ ___  _ __ __ _| |_(_) ___  _ __  ___
--  / _` |/ _ \/ __/ _ \| '__/ _` | __| |/ _ \| '_ \/ __|
-- | (_| |  __/ (_| (_) | | | (_| | |_| | (_) | | | \__ \
--  \__,_|\___|\___\___/|_|  \__,_|\__|_|\___/|_| |_|___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

hl.config({
    decoration = {
        rounding           = 18,
        active_opacity     = 1.0,
        inactive_opacity   = 0.8,
        fullscreen_opacity = 1.0,
        dim_inactive       = false,

        blur = {
            enabled          = true,
            size             = 6,
            passes           = 2,
            contrast         = 0.8,
            vibrancy         = 0.1,
            vibrancy_darkness = 0,
            new_optimizations = true,
            ignore_opacity   = true,
            noise            = 0,
            xray             = false,
            special          = true,
            popups           = true,
        },

        shadow = {
            enabled      = true,
            range        = 15,
            render_power = 5,
            color        = "rgba(0,0,0,0.5)",
        },
    },
})
