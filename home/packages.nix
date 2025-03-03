{
  pkgs,
  inputs,
  nvix,
  ...
}:
{
  home.packages = with pkgs; [
    # -- GENERAL --

    # Terminal (<3 Zig)
    ghostty

    # Diagnostics
    neofetch
    inxi
    usbutils
    upower
    lshw
    powertop
    htop

    # Finding
    ripgrep
    fzf

    # Networking
    wget
    nmap

    # Archives
    zip
    unzip

    # Clipboard
    wl-clipboard

    # Non-Nix Compatibility
    appimage-run

    # Miscellaneous Utilities
    killall
    bat

    # -- DEV --

    # Pre-configured NeoVim
    nvix.packages.${pkgs.system}.core

    # Other IDEs
    jetbrains.idea-community-bin
    vscodium

    # Nix Development Environments
    cachix
    devenv

    # Git
    git
    lazygit
    gh

    # LSPs
    java-language-server

    # Formatters
    nixfmt-rfc-style

    # -- GUIs --

    # Audio
    pavucontrol

    # Networking
    networkmanagerapplet

    # Media Viewers
    feh
    kdePackages.gwenview
    vlc

    # File Explorer
    nemo

    # -- DESKTOP --

    # Notifications
    dunst

    # Secrets
    libsecret
    keepassxc

    # Hypr*
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprshot
  ];
}
