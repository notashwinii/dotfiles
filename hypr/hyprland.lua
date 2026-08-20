-- Hyprland 0.56+ configuration.  This replaces the deprecated hyprlang file.

local terminal = "alacritty"
local menu = "wofi --show drun -n"

hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@180", position = "1920x0", scale = 1 })

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 100,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = 0.3,
        touchpad = { natural_scroll = true },
    },
    cursor = { no_hardware_cursors = true },
    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "master",
    },
    decoration = {
        rounding = 10,
        blur = { enabled = true, size = 7, passes = 2, new_optimizations = true },
    },
    animations = { enabled = false },
    dwindle = { preserve_split = true, permanent_direction_override = 1 },
    master = {
        allow_small_split = false,
        special_scale_factor = 0.8,
        mfact = 0.60,
        new_on_active = "before",
        new_on_top = false,
        orientation = "left",
        smart_resizing = true,
    },
    gestures = {
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 0,
        workspace_swipe_create_new = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

for _, workspace in ipairs({ "6", "7", "8" }) do
    hl.workspace_rule({ workspace = workspace, monitor = "eDP-1", default = true })
end

-- Start these only when Hyprland itself starts, matching exec-once in hyprlang.
hl.on("hyprland.start", function()
    for _, command in ipairs({
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
        "/home/ash/.config/hypr/xdg-portal-hyprland",
        "/home/ash/.config/waybar/launch.sh",
        "brave --profile-directory=Default",
        "alacritty",
        "discord",
        "wl-paste --type text --watch cliphist store",
        "wl-paste --type image --watch cliphist store",
        "obsidian",
        "dunst",
    }) do
        hl.exec_cmd(command)
    end
end)

-- Window rules
hl.window_rule({
    name = "xwaylandvideobridge-hide",
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = "0.0 override 0.0 override",
    no_anim = true,
    no_focus = true,
    no_initial_focus = true,
})

for _, rule in ipairs({
    { name = "ws2-zen", class = "^(.*zen.*)$", workspace = "2" },
    { name = "ws6-chromium-class", class = "^(.*Chromium.*)$", workspace = "6" },
    { name = "ws6-chromium-title", title = "^(.*Chromium.*)$", workspace = "6" },
    { name = "ws9-thorium", class = "^(.*thorium.*)$", workspace = "9" },
    { name = "ws10-notion", class = "^(.*notion.*)$", workspace = "10" },
    { name = "ws3-microsoft", class = "^(.*microsoft.*)$", workspace = "3" },
    { name = "ws5-spotify", class = "^(.*Spotify.*)$", workspace = "5" },
    { name = "ws8-obsidian", class = "^(.*obsidian.*)$", workspace = "8" },
}) do
    local match = {}
    if rule.class then match.class = rule.class end
    if rule.title then match.title = rule.title end
    hl.window_rule({ name = rule.name, match = match, workspace = rule.workspace })
end

hl.window_rule({ name = "opacity-thunar", match = { class = "^(thunar)$" }, opacity = "0.8 0.8" })
hl.window_rule({ name = "opacity-firefox-figma", match = { class = "^(firefox)$", title = "^(.*Figma.*)$" }, opacity = "1.0 1.0" })
hl.window_rule({ name = "opacity-firefox-youtube", match = { class = "^(firefox)$", title = "^(.*YouTube.*)$" }, opacity = "1.0 1.0" })

-- The old gold rectangle around Wofi was its Hyprland active-window border.
hl.window_rule({ name = "wofi-no-border", match = { class = "^(wofi)$" }, border_size = 0 })
hl.window_rule({ name = "float-thunar", match = { class = "^(thunar)$" }, float = true })
hl.window_rule({ name = "float-pavucontrol", match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ name = "float-blueman", match = { class = "^(blueman-manager)$" }, float = true, size = { 650, 400 } })

-- Keybindings
local mainMod = "SUPER"
local function bind_exec(keys, command, opts)
    hl.bind(keys, hl.dsp.exec_cmd(command), opts)
end

bind_exec(mainMod .. " + Return", terminal)
bind_exec(mainMod .. " + X", "firefox")
bind_exec(mainMod .. " + Z", "command -v zen-browser >/dev/null && zen-browser || brave")
hl.bind(mainMod .. " + K", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
bind_exec(mainMod .. " + SHIFT + S", "systemctl suspend && /home/ash/.config/hypr/swaylock.sh")
bind_exec(mainMod .. " + E", "dolphin")
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle", layout_aware = false }))
bind_exec(mainMod .. " + U", "hyprctl dispatch focusurgentorlast")
bind_exec(mainMod .. " + SHIFT + R", "/home/ash/.config/waybar/launch.sh")
bind_exec("SHIFT + SPACE", "voxtype record start")
bind_exec("SHIFT + slash", "voxtype record stop")
bind_exec("XF86AudioRaiseVolume", "pactl set-sink-volume @DEFAULT_SINK@ +10%", { repeating = true })
bind_exec("XF86AudioLowerVolume", "pactl set-sink-volume @DEFAULT_SINK@ -10%", { repeating = true })
bind_exec("XF86AudioMute", "pactl set-sink-mute @DEFAULT_SINK@ toggle")
bind_exec("XF86MonBrightnessUp", "brightnessctl set 5%+", { repeating = true })
bind_exec("XF86MonBrightnessDown", "brightnessctl set 5%-", { repeating = true })
hl.bind(mainMod .. " + Tab", hl.dsp.layout("swapwithmaster master"))
bind_exec(mainMod .. " + R", menu)
bind_exec("Print", "/home/ash/.config/hypr/screenshot.sh")
bind_exec(mainMod .. " + SHIFT + V", "/home/ash/.config/hypr/clipboard-menu.sh")
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
bind_exec(mainMod .. " + Space", menu)
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.layout("togglesplit"))

for key, direction in pairs({ h = "left", l = "right", k = "up", j = "down" }) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
end

hl.bind(mainMod .. " + S", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + Right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
