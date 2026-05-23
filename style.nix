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
    base16Scheme = builtins.toPath "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #image = ./config/assets/wall.png;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
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
