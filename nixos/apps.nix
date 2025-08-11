{ config, pkgs, ... }:

let
    unstable = import <unstable> {};
in
{
  environment.systemPackages = with pkgs; [
    #gnomeExtensions.appindicator
    vim # Do not forget to add an editor to edit configuration.nix! The Nano
  	wget
    vscode
    pkgs.xfce.thunar
    pkgs.git
    pkgs.gnumake
    pkgs.gettext
    pkgs.gnome.gvfs
    pkgs.direnv
    pkgs.keepassxc
    pkgs.insync
    pkgs.google-chrome
    pkgs.spotify
    pkgs.notepadqq
    pkgs.dconf-editor
    pkgs.gnome-tweaks
    pkgs.zoom-us
    pkgs.xfce.catfish
    pkgs.calibre
    pkgs.gimp-with-plugins
    pkgs.libreoffice
    pkgs.obs-studio
    pkgs.jdk
    pkgs.dialog
    pkgs.python312Full
    pkgs.libjpeg8
    pkgs.winetricks
    pkgs.lsof
    pkgs.gnupatch
    pkgs.libxml2
    pkgs.samba4Full
    pkgs.bc
    pkgs.cabextract
    pkgs.wineWowPackages.stagingFull
    pkgs.bc
    pkgs.wineWowPackages.stagingFull
    pkgs.fuse3
    pkgs.haskellPackages.libfuse3
    pkgs.brlaser
    pkgs.kdePackages.kdialog
    pkgs.mktemp
    pkgs.zenity
    pkgs.python312Packages.pip
    pkgs.tk
    pkgs.wireguard-tools
    pkgs.networkmanager
    pkgs.wg-netmanager
    pkgs.feh
    pkgs.dconf-editor
    pkgs.gparted
    pkgs.binutils
    pkgs.apt
    pkgs.coreutils-full
    pkgs.gnupatch
    pkgs.lsof
    pkgs.findutils
    pkgs.remmina
    pkgs.gnome-text-editor
    pkgs.mate.mate-calc
    pkgs.opera
      ];

  }


