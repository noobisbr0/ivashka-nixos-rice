{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    librsvg
  ];

  home.file = {
    ".local/share/icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
    ".local/share/icons/Papirus-Dark".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.theme = null;
    
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.configFile."hypr/hyprlauncher.conf".text = ''
    general {
        grab_focus = true
        icon_theme = Papirus-Dark
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
        # Окно стало шире и выше
        window_size = 750 500
        
        # Увеличенные иконки
        icon_size = 48
    }
  '';

  

  xdg.configFile."hypr/hyprtoolkit.conf".text = ''
    rounding = 12
    font_family = JetBrainsMono Nerd Font
    
    # Увеличенный шрифт
    font_size = 13

    background = 0xD81A1025
    base = 0xFF2D1E3E
    alternate_base = 0xFF3D2856
    accent = 0xFFD8B4FE
    accent_secondary = 0xFFBB9AF7
    text = 0xFFFFFFFF
    bright_text = 0xFFBB9AF7
  '';

    dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
