{ pkgs, ... }: {
  # Browser
  programs.firefox.enable = true;

  # Shell
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias ..="cd .."
      alias ...="cd ../.."

      alias pyenv="nix-shell ~/nixos-config/shells/pip-shell.nix && export PS1='(py) $PS1'"

      alias nec="cd ~/nixos-config"
      alias nrs="sudo nixos-rebuild switch"
    '';
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
