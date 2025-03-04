user-args:
{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Trusted Users
  nix.settings.trusted-users = [
    "root"
    "ethw"
  ];

  # Allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "idea-ultimate"
  ];

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.resumeDevice = "/dev/disk/by-partlabel/swap";

  boot.loader.grub.theme = pkgs.catppuccin-grub;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_13;
  boot.kernelParams = [ "perf_event_paranoid=1" "kptr_restrict=0" ];
  hardware.enableRedistributableFirmware = true;

  # Networking
  networking.hostName = "msi";
  networking.networkmanager.enable = true;

  # Disable Suspending
  # TODO: wlp85s0f0 is unavailable after suspending for some reason; haven't been able to fix.
  #       Forcing hibernation as a fix, which works perfectly from my limited testing.
  systemd.targets.suspend.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.logind = {
    lidSwitch = "hibernate";
  };

  # Wireguard
  networking.wireguard.enable = true;

  # Power Management
  powerManagement.enable = true;
  services.tlp.enable = true;

  # Media
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

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

  # SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      AllowUsers = [ user-args.username ];
      UseDns = true;
    };
  };

  # Users
  users.users.${user-args.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
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

  # Fonts [TODO: Move to HM]
  fonts.packages = with pkgs; [
    nerdfonts
    _0xproto
  ];

  # PERMANENT
  system.stateVersion = "24.11";
}
