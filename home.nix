{
  config,
  pkgs,
  inputs,
  lib,
  userName,
  homeDirectory,
  ...
}:
let
  stateVersion = "24.05";
in
{
  imports = [
    # For home-manager
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home = {
    username = userName;
    homeDirectory = homeDirectory;
    stateVersion = stateVersion; # Please read the comment before changing.

    file = {

      # Top Level Files symlinks
      ".local/state/noctalia/settings.toml" = {
        source = pkgs.runCommand "settings.toml" { } ''
          substitute ${./dotfiles/.config/noctalia/settings.toml} $out \
            --replace-fail "/home/koris" "${homeDirectory}"
        '';
        force = true;
      };

      ".config/niri/config.kdl".source = ./dotfiles/.config/niri/config.kdl;
      ".config/fish/config.fish".source = ./dotfiles/.config/fish/config.fish;
      #".gitconfig".source = ./dotfiles/.gitconfig;
      ".config/mommy/config.sh".source = ./dotfiles/.config/mommy/config.sh;
      ".ideavimrc".source = ./dotfiles/.ideavimrc;
      ".nirc".source = ./dotfiles/.nirc;

      # Config directories
      ".config/fastfetch".source = ./dotfiles/.config/fastfetch;
      ".config/kitty".source = ./dotfiles/.config/kitty;
      ".config/tmux/tmux.conf".source = ./dotfiles/.config/tmux/tmux.conf;
      "Pictures/Wallpapers".source = ./assets/Wallpapers;
      "Pictures/Logos".source = ./assets/logos;
      "Music/Ambient".source = ./assets/sound;

      # Individual config files
      ".config/kwalletrc".source = ./dotfiles/.config/kwalletrc;
      ".config/starship/starship.toml".source = ./dotfiles/.config/starship/starship.toml;

      ".local/share/applications/github-desktop-handler.desktop".text = ''
        [Desktop Entry]
        Name=GitHub Desktop URL Handler
        Exec=github-desktop %u
        Type=Application
        NoDisplay=true
        MimeType=x-scheme-handler/x-github-desktop-auth;x-scheme-handler/x-github-desktop-dev-auth;x-scheme-handler/x-github-client;
      '';
    };

    sessionVariables = {
      # Default applications
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";

      # XDG Base Directories
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";

      # Path modifications - now as a string
      # PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";

      # Wayland and Hyprland specific
      JAVA_AWT_WM_NOREPARENTING = 1;
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      GTK_USE_PORTAL = "1";
      NIXOS_XDG_OPEN_USE_PORTAL = "1";

      # NVIDIA specific
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";

      # Localization
      LC_ALL = "en_US.UTF-8";

      # Misc
      STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
    };

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
    ];

  };

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        marketplace
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];
    };

  gtk = {
    gtk4.theme = config.gtk.theme;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  xdg.configFile."gtk-3.0/gtk.css".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;

  programs.home-manager.enable = true;
}
