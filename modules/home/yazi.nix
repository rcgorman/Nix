{ pkgs, ... }:

{
  home.packages = with pkgs; [
    yazi
    ffmpegthumbnailer
    poppler
    imagemagick
  ];
}
