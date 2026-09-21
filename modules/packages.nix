{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Разработка и компиляторы
    wineWow64Packages.stable
    gcc
    libgcc
    gdb
    clang
    clang-tools
    cpplint
    cmake
    gnumake
    meson
    pkg-config
    boost
    ragel
    deno
    pcre
    pcre2
    sqlite
    sqlitecpp
    tinyxml-2
    bazel_8
    rustup
    nodejs_24
    typescript
    python313
    python313Packages.pip

    # Qt / C++ GUI
    qtcreator
    qt5.qtbase
    qt5.wrapQtAppsHook
    qt5.qttools
    qt5.qtscript
    qt6.qtbase
    qt6.wrapQtAppsHook
    qt6.qttools
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland

    # GTK / GNOME библиотеки
    glib
    glibc
    gtk3
    gtk-layer-shell
    cairomm
    gtkmm3
    gtksourceview3
    gtksourceviewmm
    gobject-introspection
    gjs
    gvfs
    webp-pixbuf-loader
    libdbusmenu-gtk3
    libsoup_3
    adw-gtk3

    # Графика, 3D и видео
    freecad
    orca-slicer
    blender
    freeglut
    mesa
    libGL
    libGLU
    gnuplot
    steam
    protonup-qt

    # Утилиты Hyprland / Wayland
    waybar
    wofi
    rofi
    mako
    hyprpaper
    hypridle
    hyprlock
    hyprpicker
    hyprmagnifier
    hyprlauncher
    hyprutils
    wleave
    wl-clipboard
    grim
    slurp
    swappy
    wf-recorder
    cliphist
    tuigreet
    greetd
    xwayland
    polkit_gnome
    bibata-cursors

    # Системные и консольные утилиты
    git
    wget
    curl
    axel
    rsync
    htop
    dua
    duf
    gdu
    ncdu
    yazi
    ripgrep
    jq
    coreutils
    killall
    bc
    openssl
    zip
    unzip
    xz
    pigz
    ntfs3g
    upower
    brightnessctl
    ddcutil
    ydotool
    home-manager
    repomix
    fastfetch
    cmatrix
    asciiquarium
    lavat
    sl
    pipes-rs
    clock-rs
    beep
    hyperscan
    wooz
    metar
    cava
    vim
    w3m
    starship
    zsh-powerlevel10k

    # Приложения
    firefox
    chromium
    discord
    telegram-desktop
    spotify
    vlc
    haruna
    thunar
    qbittorrent
    pcmanfm
    xarchiver
    libreoffice-qt6-fresh
    vscode
    kitty
    foot
    ghostty
    prismlauncher
    ani-cli
    yt-dlp
    amnezia-vpn

    # Аудио / Видео / Устройства
    pavucontrol
    wireplumber
    libpulseaudio
    playerctl
    mpris-timer
    bluez
    blueman
    gnome-bluetooth
    gpu-screen-recorder-gtk
    simplescreenrecorder
    gnome-network-displays

    # Интеграция окружения
    feh
    redshift
    gammastep
    libnotify
    power-profiles-daemon
    dconf
    polkit
    gnome-keyring
    xdg-user-dirs
    xdg-user-dirs-gtk
    fontconfig
    yad
    awww
    era

    # LaTeX
    texlive.combined.scheme-medium
    texlivePackages.xecyr
    gummi
  ];
}
