{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/fontconfig
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "btusb" "ideapad_laptop" ];

  networking.hostName = "legion";

  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "hyprland";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Nvidia driver configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Enable network filesystems
  services.gvfs.enable = true;

  programs.dconf.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
    font = "ter-132b";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.joshua = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [ ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = [ 
    pkgs.vim
    pkgs.git
    pkgs.wget
    pkgs.killall
    pkgs.kbd
    pkgs.xdg-user-dirs
    pkgs.pulseaudio
    pkgs.papirus-icon-theme
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # 57612: Spotify sync local files
  networking.firewall.allowedTCPPorts = [ 57612 ];
  # 5353: Spotify Connect
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
