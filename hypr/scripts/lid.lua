-- Handle the laptop lid. Runs inside Hyprland (no hyprctl round-trips), bound in remaps.lua.

local monitors = require("monitors")

local M = {}

-- Re-apply the laptop monitor rules from monitors.lua, undoing the disable from close().
function M.open()
    monitors.apply_laptop()
end

-- Only turn the laptop screen off if another monitor is connected. Otherwise leave it on, so the
-- lid switch suspends the machine (logind) instead of leaving no screen.
function M.close()
    for _, monitor in ipairs(hl.get_monitors()) do
        if not monitor.name:find("^eDP%-") then
            for _, rule in ipairs(monitors.laptop) do
                hl.monitor({ output = rule.output, disabled = true })
            end
            return
        end
    end
end

return M
