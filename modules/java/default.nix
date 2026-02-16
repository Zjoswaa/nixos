{ pkgs, lib, config, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.openjdk25;
  };
}
