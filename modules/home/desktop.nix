{ pkgs, ... }:

let
  lockIcon = pkgs.writeText "lock.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#d8b4fe" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
      <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
      <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
    </svg>
  '';

  suspendIcon = pkgs.writeText "suspend.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#7aa2f7" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
      <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
    </svg>
  '';

  rebootIcon = pkgs.writeText "reboot.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#ff9e64" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
      <path d="M23 4v6h-6"></path>
      <path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"></path>
    </svg>
  '';

  shutdownIcon = pkgs.writeText "shutdown.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#f7768e" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
      <path d="M18.36 6.64a9 9 0 1 1-12.73 0"></path>
      <line x1="12" y1="2" x2="12" y2="12"></line>
    </svg>
  '';
in
{
  # 1. Hyprland 0.57+ Lua Config
  xdg.configFile."hypr/hyprland.lua".text = ''
-- =============================================================================
-- HYPRLAND CONFIG
-- Hyprland 0.57+
-- =============================================================================

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "yazi"
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
	hl.exec_cmd("hyprlock")
end)

hl.config({
	general = {
	    layout = "dwindle",
		border_size = 2,
		gaps_in = 5,
		gaps_out = 10,
		["col.active_border"] = "rgb(d8b4fe)",
		["col.inactive_border"] = "rgb(3b0764)",
	},

    dwindle = {
        preserve_split = true,
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
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })


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


hl.bind(
	mainMod .. " + J",
	hl.dsp.layout("togglesplit")
)

hl.bind(mainMod .. " + CTRL + Left", hl.dsp.window.resize({ x = -80, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.window.resize({ x = 80, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Up", hl.dsp.window.resize({ x = 0, y = -80, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Down", hl.dsp.window.resize({ x = 0, y = 80, relative = true }), { repeating = true })

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
    path = /home/noobisbro/Pictures/vermeil.png
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


  # 6. Wleave Configuration & Dark Purple Theme
  xdg.configFile."wleave/layout.json".text = ''
{
  "buttons": [
    {
      "label": "lock",
      "action": "hyprlock",
      "text": "Блокировка",
      "keybind": "l"
    },
    {
      "label": "suspend",
      "action": "systemctl  suspend",
      "text": "Сон",
      "keybind": "u"
    },
    {
      "label": "reboot",
      "action": "systemctl reboot",
      "text": "Перезагрузка",
      "keybind": "r"
    },
    {
      "label": "shutdown",
      "action": "systemctl poweroff",
      "text": "Выключение",
      "keybind": "s"
    }
  ]
}
  '';

  xdg.configFile."wleave/style.css".text = ''
window {
    background-color: rgba(26, 16, 37, 0.85);
}

button {
    color: #d8b4fe;
    background-color: #2d1e3e;
    border: 2px solid #4a3363;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
    margin: 12px;
    padding: 24px 30px;
    font-family: "JetBrainsMono Nerd Font", "CaskaydiaCove Nerd Font", sans-serif;
    font-size: 15px;
    font-weight: bold;
    background-repeat: no-repeat;
    background-position: center 36%;
    background-size: 64px 64px;
    transition: all 0.2s cubic-bezier(0.2, 0.8, 0.2, 1);
}

button:hover {
    background-color: #3d2856;
    border-color: #bb9af7;
    color: #ffffff;
    box-shadow: 0 0 20px rgba(187, 154, 247, 0.5);
}

button:focus {
    border-color: #d8b4fe;
    background-color: #432b5e;
}

#lock {
    background-image: url("${lockIcon}");
}
#lock:hover {
    border-color: #bb9af7;
    color: #bb9af7;
}

#suspend {
    background-image: url("${suspendIcon}");
}
#suspend:hover {
    border-color: #7aa2f7;
    color: #7aa2f7;
}

#reboot {
    background-image: url("${rebootIcon}");
}
#reboot:hover {
    border-color: #ff9e64;
    color: #ff9e64;
}

#shutdown {
    background-image: url("${shutdownIcon}");
}
#shutdown:hover {
    border-color: #f7768e;
    color: #f7768e;
}
  '';
}
