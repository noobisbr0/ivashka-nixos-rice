let
  # Вставьте сюда ВАШ публичный ключ (из ~/.ssh/id_ed25519.pub)
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMGK4lsjhs/cq2m0bc6beBkAYlr5Uxqk8kznuySraUa noobisbro";
  
  # Вставьте сюда публичный ключ хоста (из /etc/ssh/ssh_host_ed25519_key.pub)
  host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxZYjOnEnuZUAr1HVOBUsiO50jf2I2q1K/Vjs4hpwI8 root@nixos";
in {
  "github-token.age".publicKeys = [ user host ];
}
