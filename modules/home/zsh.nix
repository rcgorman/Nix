{ flakeHost, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -lah";
      cat = "bat";
      grep = "rg";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";

      tf = "tofu";
      rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin#${flakeHost}";
      update = "nix flake update ~/.config/nix-darwin";
    };

    initContent = ''
      bindkey '^R' atuin-search
    '';
  };
}
