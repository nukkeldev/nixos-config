{ config, pkgs, ... }: {
  imports = [ ./john-hardware-configuration.nix ];
  
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

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = true;
  systemd.targets.hybrid-sleep.enable = false;

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
  
  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];
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

  # PERMANENT
  system.stateVersion = "24.11";
}
