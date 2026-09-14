{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/audio.nix
    ./modules/desktop.nix
    ./modules/shell.nix
    ./modules/users.nix
    ./modules/fonts.nix
    ./modules/packages.nix
    ./modules/zapret.nix
  ];

  # Экспериментальные возможности Nix и несвободные пакеты
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Автообновление
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  system.stateVersion = "25.05";
}
