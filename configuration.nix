{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  boot.loader.grub.theme = pkgs.catppuccin-grub;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_13;
  hardware.enableRedistributableFirmware = true;

  # Networking
  networking.hostName = "john";
  networking.networkmanager.enable = true;
  
  # TODO: wlp85s0f0 is unavailable after suspending for some reason; haven't been able to fix.

  # Wireguard
  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = "loose"; 
  networking.firewall.logReversePathDrops = true;

  # Power Management
  powerManagement.enable = true;
  services.tlp.enable = true;

  # Performance Scaling
  services.thermald.enable = true;

  # Timezone
  time.timeZone = "America/Los_Angeles";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Greeter
  qt.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    
    theme = "where_is_my_sddm_theme";
  };

  # Hyprland
  programs.hyprland.enable = true;
  programs.uwsm.enable = true;
  programs.hyprland.withUWSM = true;

  # Printing
  services.printing.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Non-Nix Programs
  programs.nix-ld.enable = true;

  # Touchpad
  services.libinput.enable = true;

  # Users
  users.users.ethw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.ethw = { lib, pkgs, ... }: {
    home.sessionVariables = {
      JAVA_HOME = "/home/ethw/.jdks/wpilib";
    };
    home.sessionPath = [
      "$JAVA_HOME/bin"
    ];

    # TODO
    # wayland.windowManager.hyprland = {
    #   enable = true;
    # };
     
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        alias ssh-login="ssh-add ~/.ssh/id_ed25519"

        alias nec="export WAYLAND_DISPLAY=wayland-1 && sudo -E $EDITOR /etc/nixos/configuration.nix"
	alias nrs="sudo nixos-rebuild switch"
      '';
    };

    programs.git = {
      enable = true;
      userName = "nukkeldev";
      userEmail = "110308379+nukkeldev@users.noreply.github.com";
 
      extraConfig = {
        init.defaultBranch = "main";
	credential = {
          credentialStore = "secretservice";
	  helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
    	};
      };
    };

    home.stateVersion = "24.11";
  };

  # Programs & Packages
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim wget jetbrains.idea-community-bin
    vscodium
    ghostty neofetch htop
    dunst networkmanagerapplet
    git lazygit gh
    pavucontrol powertop lshw
    wl-clipboard
    libsecret keepassxc
    dbus inxi upower
    usbutils kdePackages.gwenview dolphin
    hyprlock hypridle hyprpaper

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
  
  environment.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  # Make sure we don't lose configuration.nix
  system.copySystemConfiguration = true;

  # PERMANENT
  system.stateVersion = "24.11";
}

