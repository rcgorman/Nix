{
  homebrew = {
    enable = true;
    enableZshIntegration = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };

    brews = [
      "mas"
    ];

    casks = [
      "firefox"
      "ghostty"
      "keka"
      "kekaexternalhelper"
      "linearmouse"
      "stats"
      "visual-studio-code"
      "wireshark-app"
      "netbirdio/tap/netbird-ui"

      # Enable on the real Mac if desired.
      # "utm"

      # Optional if you prefer Homebrew over the App Store.
      # "bitwarden"
    ];

    # Keep commented in the VM unless you sign into the App Store.
    # masApps = {
    #   "Bitwarden" = 1352778147;
    # };
  };
}
