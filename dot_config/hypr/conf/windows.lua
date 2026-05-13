--           _           _
-- __      _(_)_ __   __| | _____      _____
-- \ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __|
--  \ V  V /| | | | | (_| | (_) \ V  V /\__ \
--   \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

hl.config({
    general = {
        gaps_in           = 5,
        gaps_out          = 5,
        gaps_workspaces   = 0,
        border_size       = 2,
        layout            = "master",
        resize_on_border  = true,
        hover_icon_on_border = true,
        col = {
            active_border   = { colors = { accent_color, highlight_color }},
            inactive_border = accent_color_transparent,
        },

        snap = {
            enabled     = true,
            window_gap  = 20,
            monitor_gap = 20,
        },
    },

    group = {
        col = {
            border_active   = { colors = { accent_color, highlight_color }},
            border_inactive = accent_color_transparent,
        },

        groupbar = {
            font_size             = 16,
            font_weight_active    = "bold",
            font_weight_inactive  = "bold",
            height                = 20,
            indicator_gap         = 6,
            indicator_height      = 4,
            rounding              = 4,
            round_only_edges      = false,
            gaps_in               = 20,
            gaps_out              = 5,
            text_color            = "0xffffffff",

            col = {
                active   = { colors = { accent_color, highlight_color }},
                inactive = accent_color_transparent,
            },
        },
    },
})
