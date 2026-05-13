--              _                 _   _
--   __ _ _ __ (_)_ __ ___   __ _| |_(_) ___  _ __  ___
--  / _` | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \/ __|
-- | (_| | | | | | | | | | | (_| | |_| | (_) | | | \__ \
--  \__,_|_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|___/
--
-- ----------------------------------------------------------------------------------------------------------------------------------------

hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1,  1.1}, {0.1, 1.1}  } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0,   1}    } })
hl.curve("liner",  { type = "bezier", points = { {1,    1},   {1,   1}    } })

hl.config({ animations = { enabled = true } })

hl.animation({ leaf = "windows",          enabled = true, speed = 6,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 6,  bezier = "winIn",   style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 5,  bezier = "winOut",  style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 5,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "border",           enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 30, bezier = "liner",   style = "loop" })
hl.animation({ leaf = "fade",             enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,  bezier = "wind" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6,  bezier = "default", style = "slidefadevert 20%" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,  bezier = "default", style = "popin 90%" })
