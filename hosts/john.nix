{ config, pkgs, ... }: {
  imports = [ ./john-hardware-configuration.nix ];

  nix.settings.trusted-users = [ "root" "ethw" ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.resumeDevice = "/dev/disk/by-partlabel/swap";

  boot.loader.grub.theme = pkgs.catppuccin-grub;

  systemd.targets.suspend.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_13;
  hardware.enableRedistributableFirmware = true;

  # Networking
  networking.hostName = "john";
  networking.networkmanager.enable = true;
  
  # TODO: wlp85s0f0 is unavailable after suspending for some reason; haven't been able to fix.
  #       Forcing hibernation as a fix, which works perfectly from my limited testing.

  # Wireguard
  networking.wireguard.enable = true;

  # Power Management
  powerManagement.enable = true;
  services.tlp.enable = true;

  # Performance
  services.thermald.enable = true;

  # Timezone
  time.timeZone = "America/Los_Angeles";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";

  # Greeter
  qt.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;

    theme = "where_is_my_sddm_theme";
  };
  
  services.fwupd.enable = true;
  services.logind = {
    lidSwitch = "hibernate";
  };

  # Hyprland [TODO: Migrate to home.nix]
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

  # Global Packages
  environment.systemPackages = with pkgs; [
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

  fonts.packages = with pkgs; [ nerdfonts ];

  # PERMANENT
  system.stateVersion = "24.11";
}
