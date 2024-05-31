{ inputs, pkgs, config, lib, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  themeMap = lib.fix (self: {
    "Catppuccin Mocha" = spicePkgs.themes.Comfy;
    "Catppuccin Latte" = spicePkgs.themes.Comfy;
    "Catppuccin Frappe" = spicePkgs.themes.Comfy;
    "Catppuccin Macchiato" = spicePkgs.themes.Comfy;

    default.light = self."Catppuccin Latte";
    default.dark = self."Catppuccin Macchiato";
  });

  colorschemeMap = lib.fix (self: {
    "Catppuccin Mocha" = "catppuccin-mocha";
    "Catppuccin Latte" = "catppuccin-latte";
    "Catppuccin Frappe" = "catppuccin-frappe";
    "Catppuccin Macchiato" = "catppuccin-macchiato";

    default.light = self."Catppuccin Latte";
    default.dark = self."Catppuccin Macchiato";
  });
in {
  imports = [ ./audio.nix ];
  home.packages = [ pkgs.spot ];

  programs.spicetify = {
    enable = true;

    theme = config.satellite.theming.get themeMap;
    colorScheme = config.satellite.theming.get colorschemeMap;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
      shuffle # Working shuffle
      keyboardShortcut
      skipStats # Track my skips
      listPlaylistsWithSong # Adds button to show playlists which contain a song
      playlistIntersection # Shows stuff that's in two different playlists
      fullAlbumDate
      bookmark
      trashbin
      groupSession
      wikify # Shows an artist's wikipedia entry
      songStats
      showQueueDuration
      # REASON: broken
      # https://github.com/the-argus/spicetify-nix/issues/50
      # genre
      adblock
      savePlaylists # Adds a button to duplicate playlists
    ];
  };
}
