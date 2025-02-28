{ ... }:
{
  # User
  home.username = "ethw";
  home.homeDirectory = "/home/ethw";

  # Imports
  imports = [
    ./packages.nix
    ./programs.nix
  ];

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";

    # TODO: Move this into a shell
    JAVA_HOME = "/home/ethw/.jdks/wpilib"; # Extracted from the wpilib installer
  };
  home.sessionPath = [
    "$JAVA_HOME/bin"
  ];

  # Version Locking
  home.stateVersion = "24.11"; # PERMANENT
}
