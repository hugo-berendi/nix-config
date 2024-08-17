{config, ...}: {
  programs.hyprlock = {
    enable = true;
    importantPrefixes = [];
    settings = {
      general = {
      };
      background = {
        monitor = null;
        path = toString config.stylix.image; # supports png, jpg, webp (no animations, though)

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_passes = 1; # 0 disables blurring
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      inputField = {
        monitor = null;
        size = {
          width = 200;
          height = 50;
        };
        outline_thickness = 3;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        outer_color = config.satellite.theming.colors.rgb-attrs "base0D";
        inner_color = config.satellite.theming.colors.rgb-attrs "base01";
        font_color = config.satellite.theming.colors.rgb-attrs "base05";
        fade_on_empty = true;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = config.satellite.theming.colors.rgb-attrs "base0C";
        fail_color = config.satellite.theming.colors.rgb-attrs "base08"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below

        position = {
          x = 0;
          y = 0;
        };
        halign = "center";
        valign = "center";
      };
    };
    extraConfig = ''
      # Add extra configuration here
    '';
  };
}
