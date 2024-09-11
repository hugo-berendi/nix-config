{config, ...}: let
  # Using `config.users.users.pilot.name` causes an infinite recursion error
  # due to the way the syncthing module is written
  user = config.yomi.pilot.name;
  group = "syncthing";
  dataDir = "/persist/state/var/lib/syncthing";
in {
  services.syncthing = {
    inherit user group dataDir;
    enable = true;

    openDefaultPorts = true;
    configDir = "${dataDir}/config";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      # {{{ Device ids
      devices = {
        nothing.id = "7KM7BJR-DNSYR3Q-CBAFRDC-EDFPGXS-FTY2JTK-4XDELIV-BSHBM2Y-PFOWFQJ";
        ipad.id = "UK6IU6S-IULHYLK-MVQPLC6-NYZV5BY-N6F6N2H-4PYW5UN-QWO2VBB-U3GQVA5";
        amaterasu.id = "OAW3CNC-YF5T6PX-E5BQUZL-XT2KPAO-53AEHLH-P3C7HFR-GY2ZII6-PBS55Q2";
      };
      # }}}

      extraOptions.options.crashReportingEnabled = false;
    };
  };

  # Syncthing seems to leak memory, so we want to restart it daily.
  systemd.services.syncthing.serviceConfig.RuntimeMaxSec = "1d";

  # I'm not sure this is needed anymore, I just know I got some ownership errors at some point.
  systemd.tmpfiles.rules = ["d ${dataDir} - ${user} ${group}"];
}
