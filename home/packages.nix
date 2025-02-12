{ pkgs, ... }:

let
  term = with pkgs; [
    ghostty # Terminal (<3 Zig)
  ];

  utils = with pkgs; [
    neofetch # Diagnostic(ish)
    htop inxi # System Information

    # Hardware Interaction
    usbutils upower dbus
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
     dolphin # File Explorer
  ];

  desktop = with pkgs; [
    dunst # Notifications
    libsecret keepassxc # Shhh
    hyprlock hypridle hyprpaper # Hypr*

    # Catppuccin SDDM Theme
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        backgroundFill = "#1e1e2e";
     	basicTextColor = "#cdd6f4";
        passwordCursorColor = "#cdd6f4";
        passwordInputBackground = "#1e1e2e";
        passwordTextColor = "#cdd6f4";
      };
    })
  ];
in
{
  home.packages = term ++ utils ++ dev ++ guis ++ desktop;
}

