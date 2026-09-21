{ config, ... }:

{
  age.secrets.github-token = {
    # Путь до зашифрованного файла относительно этого модуля
    file = ../secrets/github-token.age;
    
    # Владелец файла в системе
    owner = "noobisbro";
    group = "users";
    
    # Права (чтение только для владельца)
    mode = "0400";
  };

  # Если вы хотите использовать этот токен в системном окружении, 
  # можно задать переменную для него (например, для nix).
  # NixOS берет путь к расшифрованному файлу через config.age.secrets."имя".path
  nix.extraOptions = ''
    !include ${config.age.secrets.github-token.path}
  '';
}
