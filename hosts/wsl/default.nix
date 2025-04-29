{
  username,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: {
  # WSL
  wsl.enable = true;
  wsl.defaultUser = username;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Timezone
  time.timeZone = "America/Los_Angeles";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";

  # Non-Nix Programs
  programs.nix-ld.enable = true;

  # Users
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # PERMANENT
  system.stateVersion = "24.11";
}
