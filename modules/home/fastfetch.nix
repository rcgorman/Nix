{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file.".config/fastfetch/logos/nix-darwin-ascii.png".source =
    ../../assets/nix_darwin_ascii.png;

  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "kitty-direct",
        "source": "~/.config/fastfetch/logos/nix-darwin-ascii.png",
        "width": 20,
        "height": 10
      },

      "display": {
        "separator": "  "
      },

      "modules": [
        "break",
        "title",
        "break",
        { "type": "os", "key": "OS" },
        { "type": "host", "key": "Host" },
        { "type": "kernel", "key": "Kernel" },
        { "type": "uptime", "key": "Uptime" },
        { "type": "packages", "key": "Packages" },
        { "type": "shell", "key": "Shell" },
        { "type": "terminal", "key": "Terminal" },
        { "type": "cpu", "key": "CPU" },
        { "type": "memory", "key": "Memory" },
        { "type": "disk", "key": "Disk" },
        "break"
      ]
    }
  '';
}
