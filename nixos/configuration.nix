# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nix-ld.nix
    ];


# Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  #starting polkit authentication
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  #time.timeZone = "Europe/London";
  time.timeZone = "Europe/Malta";
  # Select internationalisation properties.
  #i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.sddm.wayland = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  #Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;
  #services.xserver.desktopManager.plasma5.enable = true;


  # Window Managers
  #services.xserver.windowManager.stumpwm.enable = true;
  #services.xserver.windowManager.ratpoison.enable = true;
  #services.xserver.windowManager.exwm.enable = true;
  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "extd";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  services.samba.enableWinbindd = true;

  services.blueman.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  security.polkit.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sunday = {
    isNormalUser = true;
    description = "sunday";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  programs.bash.shellAliases = {
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";
    cls = "clear";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
    fonts.packages = with pkgs; [
      fira-code
      fira
      open-sans
      cooper-hewitt
      ibm-plex
      jetbrains-mono
      iosevka
      # bitmap
      spleen
      fira-code-symbols
      powerline-fonts
      nerdfonts
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    #pkgs.displaylink
    #pkgs.wayland
    pkgs.vscode
    git
    pkgs.spotify
    pkgs.steam-tui
    pkgs.dialog
    pkgs.gnome.zenity
    pkgs.lsof
    gparted
    filezilla
    libreoffice
    zoom-us
    vlc
    etcher
    coreutils
    #binutils
    pciutils
    dmidecode
    autoconf
    #gcc
    gnumake
    llvm
    libclang
    clang
    cmake
    ncurses5
    wget
    curl
    unzip
    # nix
    nixpkgs-lint
    nixpkgs-fmt
    nixfmt
    pkgs.monitor
    pkgs.efibootmgr
    pkgs.os-prober
    pkgs.keepassxc
    pkgs.calibre
    pkgs.discord
    pkgs.cabextract
    pkgs.libjpeg8
    pkgs.bc
    pkgs.samba
    pkgs.libxml2
    #pkgs.python3
    #pkgs.tcl
    pkgs.tk
    pkgs.python311Packages.tkinter
    pkgs.file
    pkgs.libz
    pkgs.google-chrome
    pkgs.dropbox
    pkgs.gnome.gnome-system-monitor
    pkgs.xfce.catfish
    pkgs.onedrive
    pkgs.onedrivegui
    pkgs.nix-ld
    pkgs.gdrive3
    pkgs.calibre
    pkgs.evince
    pkgs.gimp-with-plugins
    pkgs.direnv
    pkgs.xfce.thunar
    pkgs.xfce.thunar-volman
    pkgs.xfce.thunar-dropbox-plugin
    pkgs.gnome.nautilus
    pkgs.cpulimit
    pkgs.libsForQt5.kate
    pkgs.authy
    pkgs.jre8
    pkgs.rofi
    pkgs.lxde.lxrandr
    pkgs.networkmanagerapplet
    pkgs.networkmanagerapplet
    pkgs.gnome.gnome-terminal
    pkgs.blueman
    pkgs.pasystray
    pkgs.dunst
    pkgs.libsForQt5.polkit-kde-agent
    pkgs.polkit_gnome
    pkgs.polkit
    pkgs.libsForQt5.polkit-qt
    pkgs.pa_applet
    pkgs.volumeicon
    pkgs.pavucontrol
    pkgs.pulseaudio
    pkgs.feh
    pkgs.i3blocks
    #pkgs.i3blocks-gaps
    pkgs.brightnessctl
    pkgs.gnome.nautilus
    pkgs.python311Packages.pip
    pkgs.python311Packages.pyinstaller-versionfile
    pkgs.libsForQt5.kalk
    # support both 32- and 64-bit applications
    #wineWowPackages.stable

    # support 32-bit only
    #wine

    # support 64-bit only
    #(wine.override { wineBuild = "wine64"; })

    # wine-staging (version with e7i%"KSuCd6mE-E%xperimental features)
    #wineWowPackages.staging
    wineWowPackages.stagingFull
    #winePackages.stagingFull

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    #wineWowPackages.waylandFull
    (python3.withPackages(ps: with ps; [ import tcl tk matplotlib django flask pandas libz requests]))
    (pkgs.wrapOBS { plugins = [ pkgs.obs-studio-plugins.obs-vaapi ]; })
  ];

  nixpkgs.config.pulseaudio = true;

  nixpkgs.config.permittedInsecurePackages = [
                 "electron-19.1.9"
               ];

  ## Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;                       # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
    "net.core.rmem_default" = 16777216;       # Default socket receive buffer size, improve network performance & applications that use sockets
    "net.core.rmem_max" = 16777216;           # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.core.wmem_default" = 16777216;       # Default socket send buffer size, improve network performance & applications that use sockets
    "net.core.wmem_max" = 16777216;           # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.ipv4.tcp_keepalive_intvl" = 30;      # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;      # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;      # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 268435456;  # 256 MB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.dirty_bytes" = 1073741824;            # 1 GB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.min_free_kbytes" = 65536;             # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
    "vm.swappiness" = 70;                      # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50;             # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
