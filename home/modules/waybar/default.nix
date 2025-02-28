{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./config);
    style = builtins.readFile ./style.css;
  };
}
