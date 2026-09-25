{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.noobisbro = { pkgs, ... }: {
    home.username = "noobisbro";
    home.homeDirectory = "/home/noobisbro";
    home.stateVersion = "25.05";

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    programs.home-manager.enable = true;

    imports = [
      ./home/desktop.nix
      ./home/waybar.nix
      ./home/terminal.nix
      ./home/launcher.nix       
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
        tg-ws = "cd /home/noobisbro/tg-ws-proxy && nix-shell --run tg-ws-proxy";
        qtprak = "cd /home/noobisbro/qt_progs && nix-shell -p qt5.qtbase -p qtcreator --run qtcreator"; 
        ani-cli = "anicli-ru cli";
        dns-toggle = "toggledns";
      };

      initContent = ''
        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[command]='fg=135,bold'
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=135,bold'
        ZSH_HIGHLIGHT_STYLES[alias]='fg=135,bold'

        toggledns() {
          local con_name=$(nmcli -t -f NAME,DEVICE connection show --active | head -n1 | cut -d: -f1)
          local iface=$(ip route show default | awk '{print $5; exit}')

          if [ -z "$con_name" ] || [ -z "$iface" ]; then
            echo "Активное подключение не найдено."
            return 1
          fi

          local ignore_dns=$(nmcli -g ipv4.ignore-auto-dns connection show "$con_name")

          if [ "$ignore_dns" = "yes" ]; then
            echo "Включаем DNS от роутера (DHCP)..."
            nmcli connection modify "$con_name" ipv4.ignore-auto-dns no ipv6.ignore-auto-dns no
            nmcli connection up "$con_name" > /dev/null
            sudo resolvectl revert "$iface"
          else
            echo "Возвращаем статичный Xbox DNS (DoT)..."
            nmcli connection modify "$con_name" ipv4.ignore-auto-dns yes ipv6.ignore-auto-dns yes
            nmcli connection up "$con_name" > /dev/null
            sudo resolvectl dns "$iface" 111.88.96.50#xbox-dns.ru 111.88.96.51#xbox-dns.ru
            sudo resolvectl dnsovertls "$iface" yes
          fi

          sudo resolvectl flush-caches
          echo "Текущий статус DNS для $iface:"
          resolvectl status "$iface"
        }
        
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };
  };
}
