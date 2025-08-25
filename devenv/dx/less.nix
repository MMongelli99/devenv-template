{pkgs, ...}: {
  packages = with pkgs; [
    less
  ];
  enterShell = ''
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
