{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  stylix = {
    enable = true;
    # TODO: Better color management? see below
    # If you change your color scheme in noctalia, the UI color scheme won't match stylix.
    # Currently, you must change the base16Scheme here and rebuild to match theme
    # At the very least, I could make an easier way to manage this
    base16Scheme = builtins.toPath "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.victor-mono;
        name = "VictorMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 9;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
