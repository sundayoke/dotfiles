# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apps.nix
      ./nix-ld.nix
      #./lxqt.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  #time.timeZone = "Europe/London";
  time.timeZone = "Europe/Malta";
  #time.timeZone = "Africa/Accra";
  #time.timeZone = "Africa/Lagos";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  ## Enable Docker
  virtualisation.docker.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.wayland.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  #services.wg-netmanager.enable = true;

## Enable MATE Desktop environment
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.mate.enable = true;

  # Enable XFCE
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  ## Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;

  ##Enable cinnamon
  services.libinput.enable = true;
  ###services.xserver.displayManager.lightdm.enable =true;
  services.xserver.displayManager.gdm.wayland.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.defaultSession = "cinnamon";


  #environment.plasma6.excludePackages = with pkgs; [
  #mate.mate-terminal
  #vlc
  #pkgs.libsForQt5.baloo
  #pkgs.kdePackages.elisa
  #pkgs.kdePackages.kate
  #pkgs.xterm
  #];

  ##Enable the Budgie Desktop Environment.
  #services.xserver.desktopManager.budgie.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;

  #environment.budgie.excludePackages = with pkgs; [
  #  mate.mate-terminal
  #  vlc
  #];

   ##Enable the LXQT Desktop Environment.
  #services.displayManager.sddm.wayland.enable = true;
  #services.xserver.desktopManager.lxqt.enable = true;

  #deepin
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.deepin.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "extd";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
	# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.sunday = {
    isNormalUser = true;
    description = "Sunday Oke";
    extraGroups = [ "networkmanager" "wheel" "root" "qemu-libvirtd" "libvirtd" "video" "audio" "disk" "docker" "networkmanager" ];
    group = "users";
    #home = "/home/sunday";
    #uid = 1000;
    packages = with pkgs; [
      #kdePackages.kate
      #thunderbird
    ];
  };

      ## Exclude the following packages from Gnome ##
    environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
]) ++ (with pkgs; [
  cheese # webcam tool
  gnome-music
  gnome-terminal
  pkgs.gedit # text editor
  epiphany # web browser
  geary # email reader
  #evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
  simple-scan
  gnome-weather
  gnome-contacts
  gnome-calculator
  pkgs.xterm
  pkgs.gnome-text-editor
  pkgs.mate.mate-calc
]);

 # Extra Window Managers
  #services.xserver.windowManager.stumpwm.enable = true;
  #services.xserver.windowManager.ratpoison.enable = true;
  #services.xserver.windowManager.exwm.enable = true;
  ##Enable the i3 Desktop Environment.
  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        pkgs.rofi
        pkgs.networkmanagerapplet
        pkgs.pasystray
        pkgs.volumeicon
        pkgs.pa_applet
        pkgs.lxde.lxrandr
     ];
    };
  # Install firefox.
  programs.firefox.enable = true;

  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;


  #environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  services.udev.packages = with pkgs; [ pkgs.gnome-settings-daemon ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_testing;

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
    "vm.swappiness" = 60;                      # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50;             # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
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
  # services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
