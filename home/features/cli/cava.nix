{config, ...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pipewire";
      smoothing.noise_reduction = 88;
      color = {
        background = "'${config.lib.stylix.scheme.withHashtag.base01}'";
        foreground = "'${config.lib.stylix.scheme.withHashtag.base0D}'";
      };
    };
  };
}
