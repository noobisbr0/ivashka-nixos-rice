{ ... }:

{
  # 1. Kitty
  programs.kitty = {
    enable = true;
    extraConfig = ''
font_family      CaskaydiaCove Nerd Font
font_size 14

bold_font        auto
italic_font      auto
bold_italic_font auto

background_opacity 0.85
blur_background yes

confirm_os_window_close 0

window_padding_width 15
window_margin_width 0
margin_width 0
dynamic_background_opacity yes

cursor_shape beam
cursor_blink_interval 0
hide_window_decorations yes

scrollback_lines 2000

background #282c34
color0 #3f4451
color16 #282c34
color8 #4f5666
color1 #e06c75
color17 #c25d66
color9 #ff7b86
color2 #98c379
color18 #82a566
color10 #b1e18b
color3 #d19a66
color19 #b38257
color11 #efb074
color4 #61afef
color20 #5499d1
color12 #67cdff
color5 #c678dd
color21 #a966bd
color13 #e48bff
color6 #56b6c2
color22 #44919a
color14 #63d4e0
color7 #e6e6e6
color23 #c8c8c8
color15 #ffffff
foreground #abb2bf

tab_bar_style powerline
window_border_width 0.5pt
window_resize_step_cells 2
window_resize_step_lines 2
initial_window_width  640
initial_window_height 400
draw_minimal_borders yes
inactive_text_alpha 0.7
hide_window_decorations no
macos_titlebar_color background
macos_thicken_font 0.75
active_border_color none
enabled_layouts splits
enable_audio_bell no

map alt+t                new_tab_with_cwd !neighbor
map alt+s                next_tab
map alt+a                previous_tab
map alt+w                close_tab
map ctrl+alt+s           set_tab_title
map alt+shift+left       move_tab_backward
map alt+shift+right      move_tab_forward

map alt+1 goto_tab 1
map alt+2 goto_tab 2
map alt+3 goto_tab 3
map alt+4 goto_tab 4
map alt+5 goto_tab 5
map alt+6 goto_tab 6
map alt+7 goto_tab 7
map alt+8 goto_tab 8
map alt+9 goto_tab 9
    '';
  };

  # 2. Mako
  services.mako = {
    enable = true;
    extraConfig = ''
sort=-time
layer=overlay
background-color=#1e222a7f
width=450
height=150
border-size=0
border-color=#14181d
border-radius=10
icons=0
max-icon-size=64
default-timeout=5000
ignore-timeout=0
font="HarmonyOS Sans SC" 16
margin=12
padding=12,20

[urgency=low]
border-color=#cccccc

[urgency=normal]
border-color=#99c0d0

[urgency=critical]
border-color=#bf616a
default-timeout=0
    '';
  };

  # 3. Fastfetch
  xdg.configFile."fastfetch/config.jsonc".text = ''
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "kitty",
    "source": "~/.config/fastfetch/image.png",
    "width": 40,
    "height": 20,
    "padding": {
      "top": 1,
      "left": 2,
      "right": 3
    }
  },
  "display": {
    "separator": ": ",
    "color": {
      "keys": "38;2;180;130;240",
      "title": "38;2;200;160;255",
      "separator": "38;2;180;130;240",
      "output": "38;2;230;215;255"
    }
  },
  "modules": [
    "title",
    "separator",
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "display",
    "wm",
    "cursor",
    "terminal",
    "terminalfont",
    "cpu",
    "gpu",
    "memory",
    "swap",
    "disk",
    "localip",
    "battery",
    "locale",
    "break",
    "colors"
  ]
}
  '';
}
