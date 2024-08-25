{disks ? ["/dev/sda"], ...}: {
  disko.devices = {
    # {{{ Disks
    disk = {
      x = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          # format = "gpt";
          partitions = {
            # {{{ Boot
            ESP = {
              # name = "ESP";
              start = "0";
              end = "512MiB";
              type = "EF00";
              # bootable = true;
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            # }}}
            # {{{ Main
            zfs = {
              # name = "zfs";
              start = "1GiB";
              end = "100%";
              priority = 2;
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
            # }}}
          };
        };
      };
    };
    # }}}
    # {{{ zpools
    zpool = {
      zroot = {
        type = "zpool";
        mountpoint = "/";

        postCreateHook = ''
          zfs snapshot zroot@blank
          zfs set keylocation="prompt" "zroot";
        '';

        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          # encryption = "aes-256-gcm";
          # keyformat = "passphrase";
          # keylocation = "file:///hermes/secrets/inari/disk.key";
          keylocation = "none";
        };

        # {{{ Datasets
        datasets = {
          "root/persist/data" = {
            type = "zfs_fs";
            mountpoint = "/persist/data";
            options."com.sun:auto-snapshot" = "true";
          };
          "root/persist/state" = {
            type = "zfs_fs";
            mountpoint = "/persist/state";
            options."com.sun:auto-snapshot" = "true";
          };
          "root/local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "root/local/cache" = {
            type = "zfs_fs";
            mountpoint = "/persist/local/cache";
          };
        };
        # }}}
      };
    };
    # }}}
  };
}
