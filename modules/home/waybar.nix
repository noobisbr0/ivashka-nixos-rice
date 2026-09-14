{ ... }:

{
  programs.waybar.enable = true;

  xdg.configFile."waybar/config.jsonc".text = ''
// -*- mode: jsonc -*-
[
{
    "layer": "top",
    "position": "top",
    "spacing": 0,
    "modules-left": [
        "hyprland/workspaces",
        "hyprland/submap",
        "custom/media"
    ],
    "modules-center": [
        "hyprland/window"
    ],
    "modules-right": [
        "bluetooth",
        "mpd",
        "pulseaudio",
        "network",
        "power-profiles-daemon",
        "cpu",
        "memory",
        "temperature",
        "backlight",
        "tray",
        "battery",
        "clock"
    ],
    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "active-only": false,
        "format": "{name}",
        "on-click": "hyprctl dispatch 'hl.dsp.focus({ workspace = {name} })'"
    },
    "hyprland/window": {
        "format": "{title}",
        "max-length": 40,
        "separate-outputs": true
    },
    "hyprland/language": {
        "format": "{variant}"
    },
    "mpd": {
        "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
        "format-disconnected": "Disconnected ",
        "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
        "unknown-tag": "N/A",
        "interval": 5,
        "consume-icons": { "on": " " },
        "random-icons": {
            "off": "<span color=\"#f53c3c\"></span> ",
            "on": " "
        },
        "repeat-icons": { "on": " " },
        "single-icons": { "on": "1 " },
        "state-icons": { "paused": "", "playing": "" },
        "tooltip-format": "MPD (connected)",
        "tooltip-format-disconnected": "MPD (disconnected)"
    },
    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "",
            "deactivated": ""
        }
    },
    "clock": {
        "timezone": "Europe/Moscow",
        "format": "{:%H:%M}",
        "format-alt": "{:%A, %B %d, %Y (%R)}",
        "tooltip-format": "<tt><small>{calendar}</small></tt>",
        "calendar": {
            "mode": "month",
            "weeks-pos": "right",
            "on-scroll": 1,
            "format": {
                "months": "<span color='#ffead3'><b>{}</b></span>",
                "days": "<span color='#ecc6d9'><b>{}</b></span>",
                "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
            }
        }
    },
    "cpu": {
        "format": "{usage}% ",
        "tooltip": false
    },
    "memory": {
        "format": "{}% ",
        "on-click": "kitty -e htop"
    },
    "temperature": {
        "critical-threshold": 80,
        "format": "{temperatureC}°C {icon}",
        "format-icons": ["", "", ""]
    },
    "backlight": {
        "format": "{percent}% {icon}",
        "format-icons": ["", "", "", "", "", "", "", "", ""]
    },
    "battery": {
        "states": { "warning": 30, "critical": 15 },
        "format": "{capacity}% {icon}",
        "format-full": "{capacity}% {icon}",
        "format-charging": "{capacity}% ",
        "format-plugged": "{capacity}% ",
        "format-alt": "{time} {icon}",
        "format-icons": ["", "", "", "", ""]
    },
    "power-profiles-daemon": {
      "format": "{icon}",
      "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
      "tooltip": true,
      "format-icons": {
        "default": "",
        "performance": "",
        "balanced": "",
        "power-saver": ""
      }
    },
    "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },
    "bluetooth": {
        "format": " {status}",
        "format-disabled": " off",
        "format-connected": " {num_connections}",
        "tooltip-format": "{controller_alias}\t{controller_address}",
        "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
        "on-click": "kitty -e bluetoothctl"
    },
    "pulseaudio": {
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    "custom/media": {
        "format": "{icon} {text}",
        "return-type": "json",
        "max-length": 40,
        "format-icons": { "spotify": "", "default": "🎜" },
        "escape": true,
        "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"
    },
    "custom/power": {
        "format" : "⏻ ",
        "tooltip": false,
        "menu": "on-click",
        "menu-file": "$HOME/.config/waybar/power_menu.xml",
        "menu-actions": {
            "shutdown": "shutdown",
            "reboot": "reboot",
            "suspend": "systemctl suspend",
            "hibernate": "systemctl hibernate"
        }
    },
    "tray": {
        "icon-size": 15,
        "spacing": 8,
        "show-passive-items": true
    }
}
]
  '';

  xdg.configFile."waybar/style.css".text = ''
window#waybar.top {
    background-color: rgba(36, 24, 45, 0.8);
    border-bottom: none;
    font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono", sans-serif;
    font-size: 11px;
    color: #d8b4fe;
    min-height: 26px;
    transition: all 0.15s ease;
}

#workspaces {
    background-color: #2d1e3e;
    margin: 2px 4px;
    padding: 0 4px;
    border-radius: 12px;
    border: 1px solid #4a3363;
}

#workspaces button {
    padding: 0;
    margin: 2px 3px;
    color: #9e85b9;
    background: transparent;
    border: none;
    border-radius: 50%;
    min-width: 20px;
    min-height: 20px;
    transition: all 0.15s cubic-bezier(0.23, 1, 0.32, 1);
}

#workspaces button.active {
    background-color: #bb9af7;
    color: #1a1b26;            
    font-weight: bold;
    border-radius: 10px;       
    min-width: 24px;           
}

#workspaces button:hover {
    background-color: rgba(187, 154, 247, 0.2);
    color: #bb9af7;
}

#workspaces button.urgent {
    background-color: #f7768e;
    color: #ffffff;
}

#window {
    color: #bb9af7;
    font-weight: bold;
    background: rgba(45, 30, 62, 0.8);
    padding: 0 8px;
    margin: 2px 0;
    border-radius: 10px;
    border: 1px solid #4a3363;
    min-width: 10px; 
}

#clock,
#battery,
#network,
#cpu,
#memory,
#temperature,
#backlight,
#language,
#bluetooth,
#pulseaudio,
#mpd,
#tray,
#idle_inhibitor,
#custom-media,
#power-profiles-daemon,
#submap {
    background-color: #2d1e3e;
    padding: 0 6px;
    margin: 2px 2px;
    border-radius: 10px;
    border: 1px solid #4a3363;
}

#battery.critical,
#temperature.critical {
    background-color: #f7768e;
    color: #ffffff;
}

#battery.warning {
    background-color: #e0af68;
    color: #1a1b26;
}

#tray > .passive,
#tray > .active,
#tray > .needs-attention {
    padding: 0 4px;
}
  '';
}
