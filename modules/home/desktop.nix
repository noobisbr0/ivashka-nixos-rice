{ ... }:

{
  # 1. Hyprland 0.57+ Lua Config
  xdg.configFile."hypr/hyprland.lua".text = ''
-- =============================================================================
-- HYPRLAND CONFIG
-- Hyprland 0.57+
-- =============================================================================

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "16")

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("nwg-drawer -r -c 7 -is 48 -wm hyprland")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 16")
end)

hl.config({
	general = {
		border_size = 2,
		gaps_in = 5,
		gaps_out = 10,
		["col.active_border"] = "rgb(d8b4fe)",
		["col.inactive_border"] = "rgb(3b0764)",
	},

	input = {
		kb_layout = "us,ru",
		kb_options = "grp:win_space_toggle",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
	},

	xwayland = {
		force_zero_scaling = true,
	},

	decoration = {
		rounding = 10,
		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = 0x66d8b4fe,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("happ"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd([[bash -c 'cliphist list | rofi -dmenu -p "Буфер обмена" | cliphist decode | wl-copy']]))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

hl.bind("ALT + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
end)

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("Print", hl.dsp.exec_cmd([[grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" - | wl-copy']]))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind("SUPER + X", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + SHIFT + X", hl.dsp.window.move({ workspace = "special" }))

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1.25,
})
  '';

  # 2. Hyprlock
  xdg.configFile."hypr/hyprlock.conf".text = ''
background {
    monitor =
    path = screenshot
    color = rgba(25, 20, 20, 1.0)
    blur_passes = 2
    blur_size = 7
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.05
}

label {
    monitor =
    text = $TIME
    color = rgba(255, 255, 255, 1.0)
    font_size = 75
    font_family = JetBrains Mono Nerd Font
    position = 0, 100
    halign = center
    valign = center
}

input-field {
    monitor =
    size = 250, 50
    outline_thickness = 2
    dots_size = 0.33
    dots_spacing = 0.15
    dots_center = true
    outer_color = rgba(255, 255, 255, 0.2)
    inner_color = rgba(0, 0, 0, 0.5)
    font_color = rgba(255, 255, 255, 1.0)
    fade_on_empty = true
    placeholder_text = <i>Введите пароль...</i> 
    hide_input = false
    position = 0, -20
    halign = center
    valign = center
}
  '';

  # 3. Hypridle
  xdg.configFile."hypr/hypridle.conf".text = ''
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'
}

listener {
    timeout = 270
    on-timeout = brightnessctl -s set 10%
    on-resume = brightnessctl -r
}

listener {
    timeout = 300
    on-timeout = hyprlock & hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'
    on-resume = hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' && brightnessctl -r
}
  '';

  # 4. Hyprpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
wallpaper {
    monitor = eDP-1
    path = /home/noobisbro/Pictures/vermeil.png
    fit_mode = cover
}

splash = false
  '';

  # 5. Hyprlauncher
  xdg.configFile."hypr/hyprlauncher.conf".text = ''
general {
    grab_focus = true
}

cache {
    enabled = true
}

finders {
    default_finder = desktop
    desktop_icons = true
    math_prefix = =
}

ui {
    window_size = 500 300
}
  '';
}
