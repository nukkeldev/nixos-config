{
  pkgs,
  nvix,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # -- GENERAL --

    # Terminal (<3 Zig)
    ghostty
    chromium
    shader-slang

    # Diagnostics
    neofetch
    inxi
    usbutils
    upower
    lshw
    powertop
    htop
    btop
    wavemon
    brightnessctl

    # Finding
    ripgrep
    fzf

    # Networking
    wget
    nmap
    aria2

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
    inotify-tools

    # Calculators
    qalculate-gtk

    # -- DEV --

    # Other IDEs
    jetbrains.idea-ultimate
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

    # Virtualization
    gnome-boxes

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
