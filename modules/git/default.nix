{ pkgs, lib, config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Zjoswaa";
        email = "joshuavdjagt@gmail.com"; 
      };
      alias = {
        st = "status";
        ci = "commit";
        br = "branch"; 
      };
    };
  };
}
