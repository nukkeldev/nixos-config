{ pkgs, ... }:

let
  term = with pkgs; [
    ghostty # Terminal (<3 Zig)
  ];

  utils = with pkgs; [
    neofetch # Diagnostic(ish)
    htop inxi # System Information

    # Hardware Interaction
    usbutils upower
    lshw powertop

    wl-clipboard # Clipboard
  ];

  dev = with pkgs; [
    neovim # Default editor
    jetbrains.idea-community-bin # As a fallback for Java
    vscodium # As a default fallback
  
    git lazygit gh # Project Management
  ];

  guis = with pkgs; [
     pavucontrol # Audio
     networkmanagerapplet # Networking
     kdePackages.gwenview feh # Image Viewers
     nemo # File Explorer
  ];

  desktop = with pkgs; [
    dunst # Notifications
    libsecret keepassxc # Shhh
    hyprlock hypridle hyprpaper hyprpicker hyprshot # Hypr*
  ];
in
{
  home.packages = term ++ utils ++ dev ++ guis ++ desktop;
}

