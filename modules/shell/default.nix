{ pkgs, lib, config, ... }:

{
  imports = [
    ./fish.nix
  ];

  fish.enable = true;
}
