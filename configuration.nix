{ config, pkgs, ... }:

{
  imports = [
    ./modules/home.nix
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/battery.nix
    ./modules/networking.nix
    ./modules/audio.nix
    ./modules/desktop.nix
    ./modules/shell.nix
    ./modules/users.nix
    ./modules/fonts.nix
    ./modules/packages.nix
    ./modules/zapret.nix
  ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    # Сколько пакетов Nix может собирать или скачивать одновременно:
    # "auto" выставляет значение равным количеству потоков CPU
    max-jobs = "auto";

    # Сколько потоков процессора выделять под компиляцию ОДНОГО пакета:
    # 0 означает "все доступные потоки" (аналог make -j$(nproc))
    cores = 0;

    # Параллельные HTTP-соединения для ускорения скачивания из binary cache
    http-connections = 50;

    # Увеличение буфера для загрузки больших пакетов
    download-buffer-size = 67108864; # 64 МБ
  };
  # Экспериментальные возможности Nix и несвободные пакеты
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Автообновление
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
  # В /etc/nixos/configuration.nix
 
  system.stateVersion = "25.05";
}
