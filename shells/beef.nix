{ pkgs ? import <nixpkgs> {}
, lib ? pkgs.lib
}:

let
  packages = (with pkgs; [
    python312
    python312Packages.pip
    python312Packages.virtualenv

    xorg.libX11
    xorg.libX11.dev

    libGL
    glfw
    libglvnd
    glm

    imgui
  ]);

in
(pkgs.buildFHSEnv {
  name = "pip-shell";
  targetPkgs = pkgs: packages;
  runScript = "bash";
  profile = "export LD_SEARCH_PATH=\"${lib.makeLibraryPath packages}:$LD_SEARCH_PATH\"";
}).env
