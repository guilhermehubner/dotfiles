#!/usr/bin/env lua
-- Change volume on the default output and show a notification.
-- Usage: volume.lua up|down|mute
-- Runs as a separate process (not inside Hyprland), since it waits on wpctl: binds must not block.

local sink = "@DEFAULT_AUDIO_SINK@"

local commands = {
    up = "wpctl set-volume -l 1.0 " .. sink .. " 5%+", -- -l 1.0 caps at 100%
    down = "wpctl set-volume " .. sink .. " 5%-",
    mute = "wpctl set-mute " .. sink .. " toggle",
}

local command = commands[arg[1]]
if not command then
    io.stderr:write("usage: " .. arg[0] .. " up|down|mute\n")
    os.exit(1)
end
os.execute(command)

-- wpctl prints e.g. "Volume: 0.45" or "Volume: 0.45 [MUTED]"
local pipe = assert(io.popen("wpctl get-volume " .. sink))
local status = pipe:read("*a")
pipe:close()

local volume = tonumber(status:match("Volume:%s*([%d.]+)")) or 0
local percent = math.floor(volume * 100 + 0.5)
local title = status:find("MUTED", 1, true) and "muted" or "volume"

os.execute(table.concat({
    "notify-send",
    "-h string:x-dunst-stack-tag:volume",
    "-h string:synchronous:volume",
    "-h int:value:" .. percent,
    "-i ~/.icons/Wings-Dark-Icons/actions/16/player-volume.svg",
    "-t 500",
    title,
}, " "))
