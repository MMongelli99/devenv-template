{pkgs, ...}: {
  imports = [
    ./xdg.nix # import this first so that expected XDG dirs are present
    ./prompt.nix
    ./neovim
    ./clipboard.nix
  ];
  packages = with pkgs; [
    git
    openssh
    less
    devenv
    which
    eza
    ripgrep
    fzf
    jq
    bat
  ];

  xdg.enable = true;

  enterShell = ''
    repo_name="$(basename `git rev-parse --show-toplevel`)"
    export name="$repo_name"

    # convenient view of git log
    alias gg='\
    git log \
    --graph --decorate --color \
    --format="%C(auto)%h%Creset %C(bold blue)%ad%Creset %C(auto)%d%Creset %s" \
    --date=iso $(git rev-list -g --all)\
    '

    # better ls
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -a"
    alias lla="eza -la"
    alias lt="eza -T"

    # colored man pages
    export PAGER="less"
    export GROFF_NO_SGR=1
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
  '';
}
