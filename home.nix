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
  home = {
    username = userName;
    homeDirectory = homeDirectory;
    stateVersion = stateVersion; # Please read the comment before changing.

    file = {

      # Top Level Files symlinks
      ".local/state/noctalia/settings.toml".source = ./dotfiles/.config/noctalia/settings.toml;
      ".config/niri/config.kdl".source = ./dotfiles/.config/niri/config.kdl;
      ".config/fish/config.fish".source = ./dotfiles/.config/fish/config.fish;
      #".gitconfig".source = ./dotfiles/.gitconfig;
      ".ideavimrc".source = ./dotfiles/.ideavimrc;
      ".nirc".source = ./dotfiles/.nirc;
      "Pictures/Wallpapers".source = ./assets/Wallpapers;
      "Pictures/Logos".source = ./assets/logos;

      # Config directories
      ".config/fastfetch".source = ./dotfiles/.config/fastfetch;
      ".config/kitty".source = ./dotfiles/.config/kitty;
      ".config/tmux/tmux.conf".source = ./dotfiles/.config/tmux/tmux.conf;

      # Individual config files
      ".config/kwalletrc".source = ./dotfiles/.config/kwalletrc;
      ".config/starship/starship.toml".source = ./dotfiles/.config/starship/starship.toml;
      ".config/starship/powerline.toml".source = ./dotfiles/.config/starship/powerline.toml;
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
    };

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
    ];

  };

  imports = [
    # For home-manager
    inputs.spicetify-nix.homeManagerModules.default
  ];

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

  programs.home-manager.enable = true;
}
