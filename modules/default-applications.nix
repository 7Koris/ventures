{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  xdg.mime.defaultApplications = {
    # Web and HTML
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";

    # File management
    "inode/directory" = "org.kde.nemo.desktop";

    # Text editor
    "text/plain" = "vim.desktop";

    # Terminal
    "x-scheme-handler/terminal" = "kitty.desktop";
    
    # GitHub Desktop protocol handlers
    "x-scheme-handler/x-github-desktop-auth" = "github-desktop.desktop";
    "x-scheme-handler/x-github-desktop-dev-auth" = "github-desktop.desktop";
    "x-scheme-handler/x-github-client" = "github-desktop.desktop";

    # Videos
    "video/quicktime" = "io.github.celluloid_player.Celluloid.desktop";
    "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
    "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
    "video/x-msvideo" = "io.github.celluloid_player.Celluloid.desktop";
    "video/x-ms-wmv" = "io.github.celluloid_player.Celluloid.desktop";
    "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
    "video/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
    "video/x-flv" = "io.github.celluloid_player.Celluloid.desktop";
    "video/3gpp" = "io.github.celluloid_player.Celluloid.desktop";
    "video/ogg" = "io.github.celluloid_player.Celluloid.desktop";

    # Audio
    "audio/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/mp4" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/ogg" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/flac" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/wav" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/x-wav" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/webm" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/aac" = "io.github.celluloid_player.Celluloid.desktop";
    "audio/opus" = "io.github.celluloid_player.Celluloid.desktop";

    #     # LibreOffice formats
    #     "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
    #     "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice-calc.desktop";
    #     "application/vnd.oasis.opendocument.presentation" = "libreoffice-impress.desktop";
    #     "application/vnd.ms-excel" = "libreoffice-calc.desktop";
    #     "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
    #     "application/msword" = "libreoffice-writer.desktop";
    #     "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
    #       "libreoffice-writer.desktop";
    #     "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
    #     "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
    #       "libreoffice-impress.desktop";

    # PDF
    "application/pdf" = "firefox.desktop";

    # Torrents
    #     "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
    #     "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";

    # Other handlers
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
}
