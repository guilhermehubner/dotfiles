-- Keybindings
-- See https://wiki.hypr.land/configuring/core/binds/
-- Flags: repeating = old `e`, locked = old `l`, release = old `r`, mouse = old `bindm`

local vars = require("variables")
local lid = require("scripts.lid")

local mainMod = vars.mainMod

local function key(mods, k)
    return mods .. " + " .. k
end

-- Apps
hl.bind(key(mainMod, "Return"), hl.dsp.exec_cmd("alacritty"))
hl.bind(key(mainMod, "P"), hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(key(mainMod, "D"), hl.dsp.exec_cmd("rofi -show window"))

-- Windows
hl.bind(key(mainMod, "Q"), hl.dsp.window.close())
hl.bind(key(mainMod, "SHIFT + Q"), hl.dsp.exit())
hl.bind(key(mainMod, "SHIFT + Space"), hl.dsp.window.float())
hl.bind(key(mainMod, "F"), hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(key(mainMod, "C"), hl.dsp.window.center())

-- Lock and suspend. `lock` waits until the screen is locked (-f), then suspends. No sudo:
-- systemctl suspend works without it for the logged-in user (sudo couldn't prompt here anyway).
hl.bind(key(mainMod, "SHIFT + L"), hl.dsp.exec_cmd(vars.lock .. " && systemctl suspend"))

-- Hide/show waybar (SIGUSR1 toggles it), or start it if it isn't running
hl.bind(key(mainMod, "B"), hl.dsp.exec_cmd("pkill -SIGUSR1 waybar || waybar"), { release = true })

-- Resize the master area (layout = master, so mfact rather than dwindle's splitratio)
hl.bind(key(mainMod, "left"), hl.dsp.layout("mfact -0.03"), { repeating = true, locked = true })
hl.bind(key(mainMod, "right"), hl.dsp.layout("mfact +0.03"), { repeating = true, locked = true })

-- Move focus
hl.bind(key(mainMod, "K"), hl.dsp.window.cycle_next({ next = false }))
hl.bind(key(mainMod, "J"), hl.dsp.window.cycle_next())

hl.bind(key(mainMod, "ALT + K"), hl.dsp.window.swap({ prev = true }))
hl.bind(key(mainMod, "ALT + J"), hl.dsp.window.swap({ next = true }))

-- Switch workspaces with mainMod + [1-5]
-- Move active window to a workspace with mainMod + SHIFT + [1-5]
for i = 1, 5 do
    hl.bind(key(mainMod, i), hl.dsp.focus({ workspace = i }))
    hl.bind(key(mainMod, "SHIFT + " .. i), hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(key(mainMod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(key(mainMod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86AudioMedia", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Volume, on the current output device. The script caps volume at 100% and shows the notification.
local volume = vars.scripts .. "/volume.lua"
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volume .. " up"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volume .. " down"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volume .. " mute"), { locked = true })

-- Screen brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true, locked = true })

-- Lid: closing turns the laptop screen off only when another monitor is connected; without one,
-- the system suspends (logind) and swayidle locks first. Opening restores the rules in monitors.lua.
hl.bind("switch:off:Lid Switch", lid.open, { locked = true })
hl.bind("switch:on:Lid Switch", lid.close, { locked = true })

-- Screenshots (exec_cmd runs through sh -c, so $(...) works)
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" "$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"'))
