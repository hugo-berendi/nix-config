{
  programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.command-not-found.enable = false;
}
