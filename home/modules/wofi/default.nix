{...}: {
  programs.wofi = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      gtk_dark = true;
      show = "drun";
    };
  };
}
