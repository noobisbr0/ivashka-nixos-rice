{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };

    interactiveShellInit = ''
      typeset -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[command]='fg=135,bold'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=135,bold'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=135,bold'
    '';

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    # Исправленный блок алиасов без повторного programs.zsh
    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      update = "cd /etc/nixos && nix flake update && git add flake.lock && sudo nixos-rebuild switch --flake .#nixos";
    };
  };

  programs.gpu-screen-recorder.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
