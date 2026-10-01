{ pkgs, ... }:

{
  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Графика и OpenCL / ROCm
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
    ];
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      #Policy = {
      #  AutoEnable = true;
      #};
    };
  };
}
