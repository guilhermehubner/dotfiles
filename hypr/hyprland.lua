-- Hyprland entry point: everything lives in the modules required below.
-- Hyprland adds this directory to package.path, so require("env") loads env.lua from here.
-- Shared values ($mainMod, $lock, ...) live in variables.lua; modules that need them require it.
-- See https://wiki.hypr.land/configuring/

require("env")
require("monitors")
require("autostart")
require("input")
require("look")
require("remaps")
