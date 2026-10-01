{ pkgs, inputs, ... }:

{
  # Разрешаем несвободный пакет LM Studio
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "lmstudio"
    ];

  # Базовая поддержка графического ускорения (OpenGL/Vulkan)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Добавляем пакет из flake inputs в систему
  environment.systemPackages = [
    inputs.lmstudio.packages.${pkgs.system}.default
  ];
}
