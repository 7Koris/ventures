{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Text editors and IDEs
    nano
    vscode

    # Programming languages and tools
    python3
    python3Packages.pip
    uv
    clang
    rustup
    rustc
    cargo
    gcc
    openssl
    godot
    lazygit
    direnv

    # Version control and development tools
    git
    gh
    gnumake
    coreutils
    nixfmt
    nixfmt-tree

    # Shell and terminal utilities
    tldr
    jq
    meow
    mommy
    lsd
    vim
    neovim
    fish
    wget
    killall
    eza
    starship
    kitty
    zoxide
    fzf
    tmux
    tree
    exfatprogs

    # File management and archives
    nemo
    p7zip
    unzip
    zip
    unrar
    file-roller
    ncdu
    duf

    # System monitoring and management
    htop
    mission-center
    lm_sensors
    inxi
    nvtopPackages.nvidia
    #anydesk

    # Network and internet tools
    aria2

    # Audio and video
    celluloid
    mpv
    vlc
    pavucontrol
    ffmpeg
    audacity

    # Image and graphics
    papirus-icon-theme
    papirus-folders
    imagemagick
    gimp
    imv

    # Virtualization
    libvirt
    qemu
    virt-manager
    spice
    spice-gtk
    spice-protocol
    OVMF

    # Productivity and office
    obsidian

    # Communication and social
    vesktop
    discord

    # Browsers
    firefox

    # Gaming and entertainment
    # steam

    # System utilities
    virt-viewer
    xwayland-satellite
    libgcc
    bc
    libnotify
    v4l-utils
    ydotool
    pciutils
    socat
    ripgrep
    lshw
    bat
    pkg-config
    brightnessctl
    virt-viewer
    appimage-run
    playerctl
    nh

    # Wayland specific
    wl-clipboard

    # File systems
    ntfs3g
    os-prober

    # Downloaders
    yt-dlp
    localsend

    # Clipboard managers
    cliphist

    # Fun and customization
    lolcat
    fastfetch

    # Networking
    networkmanagerapplet

    # Education
    wireshark
    blockbench

    # Music and streaming
    pear-desktop

    # Miscellaneous
    # libsForQt5.qt5.qtgraphicaleffects
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };  
}
