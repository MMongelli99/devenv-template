{pkgs, ...}: {
  imports = [
    ./xdg.nix
    ./prompt.nix
    ./neovim
    ./git.nix
    ./clipboard.nix
    ./eza.nix
    ./less.nix
    ./overrideShellName.nix
  ];

  packages = with pkgs; [
    devenv
    openssh
    which
    ripgrep
    fzf
    jq
    bat
  ];

  xdg.enable = true;

  overrideShellName = {
    enable = false;
    prefix = "devenv-shell-env<";
    text = "custom-default";
    suffix = ">";
  };
}
