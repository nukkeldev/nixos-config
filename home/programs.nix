{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./modules ];

  # Browser
  programs.firefox.enable = true;

  # FZF
  programs.fzf.enable = true;
  programs.fd.enable = true;

  # Eza
  programs.eza.enable = true;

  # nix-index
  programs.nix-index.enable = true;

  # Editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "rose_pine";
      editor = {
        line-number = "relative";
        bufferline = "always";
      };
      keys = {
        normal = {
          "-" = ":w";
        };
        insert = {
          "A-x" = "normal_mode";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
      {
        name = "zig";
        auto-format = true;
      }
    ];
  };

  # Shell
  programs.bash = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      ".." = "cd ..";

      "nec" = "$EDITOR ~/nixos-config";
      "nrs" = "sudo nixos-rebuild switch --flake ~/nixos-config";

      "DONOTSLEEP" = "systemd-inhibit --what=handle-lid-switch sleep infinity";
    };
  };

  # Jujutsu
  programs.jujutsu.enable = true;

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
