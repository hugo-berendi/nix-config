{
  lib,
  config,
  ...
}: let
  websiteBlocklist = [
    "www.saashub.com"
    "slant.co"
    "nix-united.com"
    "libhunt.com"
    "www.devopsschool.com"
    "medevel.com"
    "alternativeto.net"
    "linuxiac.com"
    "www.linuxlinks.com"
    "sourceforge.net"
  ];
in {
  virtualisation.oci-containers.containers.whoogle-search = {
    image = "benbusby/whoogle-search";
    autoStart = true;
    ports = ["${toString config.satellite.nginx.at.search.port}:5000"]; # server:docker
    environment = {
      WHOOGLE_UPDATE_CHECK = "0";
      WHOOGLE_CONFIG_DISABLE = "0";
      WHOOGLE_CONFIG_BLOCK = lib.concatStringsSep "," websiteBlocklist;
      WHOOGLE_CONFIG_THEME = "system";
      WHOOGLE_ALT_WIKI = ""; # disable redirecting wikipedia links
      WHOOGLE_ALT_RD = config.satellite.nginx.at.redlib.host;
      WHOOGLE_ALT_YT = config.satellite.nginx.at.yt.host;
    };
  };

  satellite.nginx.at.search.port = config.satellite.ports.whoogle;
}