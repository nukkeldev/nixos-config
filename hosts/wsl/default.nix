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

  # PERMANENT
  system.stateVersion = "24.11";
}
