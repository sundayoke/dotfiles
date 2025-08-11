{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      #pkgs.blueman
      #pkgs.firefox
    ];
  };

  #sound.enable = true;
  programs.nm-applet.enable = true;
}
