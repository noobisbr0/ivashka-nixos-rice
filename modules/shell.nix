{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.gpu-screen-recorder.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
