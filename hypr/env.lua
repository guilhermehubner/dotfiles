-- Environment variables
-- See https://wiki.hypr.land/configuring/core/environment-variables/

-- Use nvidia graphics
--hl.env("LIBVA_DRIVER_NAME", "nvidia")
--hl.env("GBM_BACKEND", "nvidia-drm")
--hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
--hl.env("AQ_DRM_DEVICES", "/dev/dri/card0")

-- Use integrated graphics
hl.env("__EGL_VENDOR_LIBRARY_FILENAMES", "/usr/share/glvnd/egl_vendor.d/50_mesa.json")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Cursor size, for XWayland apps and for hyprcursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Application compatibilities
-- Prefer Wayland but fall back to X11, so apps without Wayland support still start
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- Replaces the deprecated QT_AUTO_SCREEN_SCALE_FACTOR
hl.env("QT_ENABLE_HIGHDPI_SCALING", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
-- Replaces OZONE_PLATFORM, which Electron apps don't read
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
