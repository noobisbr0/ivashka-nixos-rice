{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.noobisbro = { pkgs, ... }: {
    home.username = "noobisbro";
    home.homeDirectory = "/home/noobisbro";
    home.stateVersion = "25.05";
    
    programs.home-manager.enable = true;

    imports = [
      ./home/desktop.nix
      ./home/waybar.nix
      ./home/terminal.nix
    ];

    # Декларативный Git
    programs.git = {
      enable = true;
      settings.user.name = "noobisbr0";
      settings.user.email = "noobisbro@ro.ru";
    };

    # Пользовательский Zsh с Powerlevel10k
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      shellAliases = {
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        update = "cd /etc/nixos && nix flake update && git add flake.lock && sudo nixos-rebuild switch --flake .#nixos";
        tg-ws = "cd /home/noobisbro/tg-ws-proxy && nix-shell && tg-ws-proxy";
        qtprak = "cd /home/noobisbro/qt_progs && nix-shell -p qt5.qtbase -p qtcreator --run qtcreator"; 
      };

      initContent = ''
        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[command]='fg=135,bold'
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=135,bold'
        ZSH_HIGHLIGHT_STYLES[alias]='fg=135,bold'

        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };
  };
}
