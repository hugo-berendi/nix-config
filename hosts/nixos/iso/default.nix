# See the wiki for more details https://wiki.nixos.org/wiki/Creating_a_NixOS_live_CD
#
# Can be built with
# nix build .#nixosConfigurations.iso.config.system.build.isoImage
{
  modulesPath,
  inputs,
  pkgs,
  outputs,
  ...
}: {
  # {{{ Imports
  imports =
    builtins.attrValues outputs.nixosModules
    ++ [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

      inputs.stylix.nixosModules.stylix
      inputs.sops-nix.nixosModules.sops

      ../../../common
      ../common/global/wireless
      ../common/global/services/openssh.nix
      ../common/global/cli/fish.nix
      ../common/users/pilot.nix
      ../common/optional/desktop
      ../common/optional/wayland/hyprland.nix
    ];
  # }}}

  # {{{ Automount kagutsuchi
  fileSystems."/kagutsuchi" = {
    device = "/dev/disk/by-label/kagutsuchi";
    neededForBoot = true;
    options = [
      "nofail"
      "x-systemd.automount"
    ];
  };
  # }}}
  # {{{ Nix config
  nix = {
    # Flake support and whatnot
    package = pkgs.lix;

    # Enable flakes and new 'nix' command
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  # }}}

  # Tell sops-nix to use the hermes keys for decrypting secrets
  sops.age.sshKeyPaths = ["/kagutsuchi/secrets/kagutsuchi/ssh_host_ed25519_key"];

  environment.systemPackages = let
    cloneConfig = pkgs.writeShellScriptBin "liftoff" ''
      git clone git@github.com:hugo-berendi/nix-config.git
      cd nix-config
    '';
  in
    with pkgs; [
      sops # Secret editing
      neovim # Text editor
      cloneConfig # Clones my nixos config from github
    ];

  # Fast but bad compression
  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}