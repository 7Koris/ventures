{
  inputs,
  pkgs,
  userName,
  homeDirectory,
  userDescription,
  system,
  hostName,
  timeZone,
  ...
}:
{
  home-manager.users.${userName}= {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;

      settings = {
        # This may also be a string or path to a .toml file.
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = "${homeDirectory}/Pictures/Wallpapers/default.png";
        };
      };
    };
  };
}
