{ pkgs, ... }:
{
  imports = [ ./modules ];

  # Browser
  programs.firefox.enable = true;

  # Shell
  programs.bash = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      ".." = "cd ..";

      "nec" = "nvim ~/nixos-config";
      "nrs" = "sudo nixos-rebuild switch --flake ~/nixos-config";

      "DONOTSLEEP" = "systemd-inhibit --what=handle-lid-switch sleep infinity";
    };
  };

  # Git
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
}
