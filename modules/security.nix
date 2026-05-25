{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  security = {
    rtkit.enable = true;
    sudo.package = pkgs.sudo.override { withInsults = true; };
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        })
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };
}
