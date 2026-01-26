{ pkgs, lib, config, ... }:

{
  options = {
    fish.enable = lib.mkEnableOption "Enable fish shell";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        ".." = "cd ..";
        la = "ls -a";
        ll = "ls -l";
        lla = "ls -l -a";
        py = "python";
      };
      interactiveShellInit = ''
        set fish_greeting
      '';
      functions.fish_prompt = {
        body = ''
          set -l retc red
          test $status = 0; and set retc green
    
          set -q __fish_git_prompt_showupstream
          or set -g __fish_git_prompt_showupstream auto
    
          function _nim_prompt_wrapper
            set retc $argv[1]
            set -l field_name $argv[2]
            set -l field_value $argv[3]
            set_color normal
            set_color $retc
            echo -n '─'
            set_color -o green
            echo -n '['
            set_color normal
            test -n $field_name
            and echo -n $field_name:
            set_color $retc
            echo -n $field_value
            set_color -o green
            echo -n ']'
          end
    
          set_color -o green
          echo -n [
    
          if functions -q fish_is_root_user; and fish_is_root_user
            set_color -o red
          else
            set_color -o yellow
          end
    
          echo -n $USER
          set_color -o white
          echo -n @
    
          if test -z "$SSH_CLIENT"
            set_color -o blue
          else
             set_color -o cyan
          end
    
          echo -n (prompt_hostname)
          set_color -o white
          echo -n :(prompt_pwd)
          set_color -o green
          echo -n ']'
    
          # Virtual Environment
          set -q VIRTUAL_ENV_DISABLE_PROMPT
          or set -g VIRTUAL_ENV_DISABLE_PROMPT true
          set -q VIRTUAL_ENV
          and _nim_prompt_wrapper $retc V (path basename "$VIRTUAL_ENV")
    
          # git
          set -l prompt_git (fish_git_prompt '%s')
          test -n "$prompt_git"
          and _nim_prompt_wrapper $retc G $prompt_git
    
          # Battery status
          type -q acpi
          and acpi -a 2>/dev/null | string match -rq off
          and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)
    
          # New line
          echo
    
          # Background jobs
          set_color normal
    
          for job in (jobs)
            echo -n '  '
            set_color brown
            echo $job
          end
    
          set_color normal
          set_color -o red
          echo -n '$ '
          set_color normal
        '';
      };
    };
  };
}
