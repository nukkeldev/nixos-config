{ pkgs, inputs, ... }: {
  # Imports
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  # Browser
  programs.firefox.enable = true;

  # Shell
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias ..="cd .."
      alias ...="cd ../.."

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

  # Nixvim
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;

    plugins = { 
      conform-nvim = {
        enable = true;
        settings.formattersByFt = {
      	  nix = [ "nixfmt" ];
        };
      };  
      chadtree.enable = true;
      
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          java_language_server.enable = true;
	  pylyzer.enable = true;
	  ruff.enable = true;
        }; 
      };
    };
  };
}
