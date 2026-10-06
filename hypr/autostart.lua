-- Programs started once at login
-- See https://wiki.hypr.land/configuring/core/autostart/

local vars = require("variables")

hl.on("hyprland.start", function()
    -- Hyprland starts xdg-desktop-portal-hyprland on its own; the portal only needs these variables
    -- to find the session (screen sharing, file pickers).
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i ~/Pictures/wallpaper.jpg")

    -- Notification daemon (config linked by the Makefile). Change to `dunst` if that's what you use.
    hl.exec_cmd("mako")

    -- Polkit agent, so GUI apps can ask for your password when they need admin rights.
    -- Needs the hyprpolkitagent package; on other setups use e.g. polkit-gnome's agent instead.
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Lock after 10 minutes idle, and always before the system goes to sleep (lid, menu or keybind)
    hl.exec_cmd(string.format("swayidle -w timeout 600 '%s' before-sleep '%s'", vars.lock, vars.lock))
end)
