{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Ryan";
      user.email = "ryan@gormantech.com";

      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pull.rebase = false;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };
}
