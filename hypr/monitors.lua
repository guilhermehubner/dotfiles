-- Monitors
-- See https://wiki.hypr.land/configuring/core/monitors/

local M = {}

-- Laptop panels. scripts/lid.lua disables these when the lid closes.
M.laptop = {
	{ output = "eDP-1", mode = "2560x1600@240", position = "0x0", scale = 1 },
	{ output = "eDP-2", mode = "2560x1600@240", position = "0x0", scale = 1 },
}

-- (Re)apply the laptop monitor rules. Also called when the lid opens, to undo the disable.
function M.apply_laptop()
	for _, rule in ipairs(M.laptop) do
		hl.monitor(rule)
	end
end

M.apply_laptop()

--hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@75", position = "2560x0", scale = 1 })

-- Any other monitor that gets plugged in: preferred resolution, placed automatically
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

return M
