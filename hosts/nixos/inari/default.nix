{
  imports = [
    ../common/global
    ../common/users/pilot.nix
    # ../common/optional/services/kanata.nix
    # ../common/optional/services/restic

    # ./services/syncthing.nix
    # ./services/whoogle.nix
    # ./services/pounce.nix
    # ./services/intray.nix
    # ./services/smos.nix
    # ./services/vaultwarden.nix
    # ./services/actual.nix
    # ./services/homer.nix
    # ./services/zfs.nix
    # ./services/prometheus.nix
    # ./services/grafana.nix
    # ./services/commafeed.nix
    # ./services/invidious.nix
    # ./services/diptime.nix
    # ./services/radicale.nix
    # ./services/redlib.nix
    # ./services/jellyfin.nix
    # ./services/qbittorrent.nix # turned on/off depending on whether my vpn is paid for
    # ./services/microbin.nix
    # ./services/forgejo.nix
    # ./services/jupyter.nix
    # ./services/ddclient.nix
    # ./filesystems
    # ./hardware
  ];

  # Machine ids
  networking.hostName = "lapetus";
  networking.hostId = "08357db3";
  environment.etc.machine-id.text = "d9571439c8a34e34b89727b73bad3587";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
}
