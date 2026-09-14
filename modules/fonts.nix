{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    material-symbols
    nerd-fonts.meslo-lg
    nerd-fonts.space-mono
    nerd-fonts.jetbrains-mono
    line-awesome
    liberation_ttf
    dejavu_fonts
    inter
    roboto
    ubuntu-sans
    fira-code
    fira-code-symbols
    dina-font
    noto-fonts-color-emoji
    proggyfonts
    corefonts
    vista-fonts
  ];
}
