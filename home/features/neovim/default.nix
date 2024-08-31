{
  inputs,
  pkgs,
  upkgs,
  lib,
  config,
  ...
}: let
  # {{{ Client wrapper
  # Wraps a neovim client, providing the dependencies
  # and setting some flags:
  wrapClient = {
    base,
    name,
    binName ? name,
    extraArgs ? "",
    wrapFlags ? lib.id,
  }:
    pkgs.symlinkJoin {
      inherit (base) name meta;
      paths = [base];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/${binName} \
          ${extraArgs}
      '';
    };
  # }}}
  # {{{ Clients
  neovide = wrapClient {
    base = pkgs.neovide;
    name = "neovide";
    extraArgs = "--set NEOVIDE_MULTIGRID true";
    wrapFlags = flags: "-- ${flags}";
  };
  # }}}
in {
  # {{{ Imports
  imports = [
    ./settings.nix
  ];
  # }}}
  # {{{ nixvim config
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    package =
      if config.satellite.toggles.neovim-nightly.enable
      then pkgs.neovim-nightly
      else upkgs.neovim;
  };
  # }}}
  satellite.lua.styluaConfig = ../../../../stylua.toml;

  # {{{ Basic config
  # We want other modules to know that we are using neovim!
  satellite.toggles.neovim.enable = true;

  # Link files in the appropriate places
  # xdg.configFile.nvim.source = config.satellite.dev.path "home/features/cli/neovim/config";
  home.sessionVariables.EDITOR = "nvim";

  home.packages = [
    neovide
    pkgs.vimclip
  ];
  # }}}
  # {{{ nixvim theming
  programs.nixvim = {
    colorschemes.base16 = {
      colorscheme = {
        inherit
          (config.lib.stylix.colors.withHashtag)
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
          ;
      };

      enable = true;
    };

    highlight = let
      transparent = {
        bg = "none";
        ctermbg = "none";
      };
    in {
      Normal = transparent;
      NonText = transparent;
      SignColumn = transparent;
    };
  };
  # }}}
  # {{{ Persistence
  satellite.persistence.at.state.apps.neovim.directories = [
    ".local/state/nvim"
    "${config.xdg.dataHome}/nvim"
  ];

  satellite.persistence.at.cache.apps.neovim.directories = [
    "${config.xdg.cacheHome}/nvim"
    # mirosSnippetCache
  ];
  # }}}
}
