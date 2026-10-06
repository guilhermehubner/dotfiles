-- Shared variables, used by autostart.lua and remaps.lua

local M = {}

M.mainMod = "SUPER"
M.scripts = "~/.config/hypr/scripts"

-- -f makes swaylock return only once the screen is actually locked, so `lock .. " && systemctl suspend"`
-- can't suspend before the lock screen is up.
M.lock = "swaylock -f -c 24283b --inside-color 24283b --indicator-radius=150 -l"

return M
