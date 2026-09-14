{ ... }:

{
  networking.hostName = "nixos";

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    connectionConfig = {
      "ipv4.ignore-auto-dns" = "yes";
      "ipv6.ignore-auto-dns" = "yes";
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "true";
      FallbackDNS = [ ];
      DNSSEC = "false";
    };
  };

  networking.nameservers = [
    "111.88.96.50#xbox-dns.ru"
    "111.88.96.51#xbox-dns.ru"
  ];

  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 7236 ];
    allowedUDPPortRanges = [
      { from = 32768; to = 60999; }
    ];
  };
}
