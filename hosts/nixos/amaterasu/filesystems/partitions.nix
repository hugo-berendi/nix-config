{disks ? ["/dev/nvme0n1"], ...}: {
  disko.devices.disk.main = {
    type = "disk";
    device = builtins.elemAt disks 0;
    content = {
      type = "gpt";
      partitions = {
        # {{{ Boot
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["defaults"];
          };
        };
        # }}}
        # {{{ Luks
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted";
            passwordFile = "/kagutsuchi/secrets/amaterasu/disk.key";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                # {{{ /
                "root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # }}}
                # {{{ /swap
                "swap" = {
                  mountpoint = "/.swapvol";
                  swap.swapfile.size = "20G";
                };
                # }}}
                # {{{ /persist/data
                "persist-data" = {
                  mountpoint = "/persist/data";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # }}}
                # {{{ /persist/state
                "persist-state" = {
                  mountpoint = "/persist/state";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # }}}
                # {{{ /local/nix
                "local-nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # }}}
                # {{{ /local/cache
                "local-cache" = {
                  mountpoint = "/persist/local/cache";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # }}}
              };
            };
          };
        };
        # }}}
      };
    };
  };
}