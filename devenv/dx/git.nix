{pkgs, ...}: {
  packages = with pkgs; [
    git
  ];
  enterShell = ''
    # convenient view of git log
    alias gg='\
    git log \
    --graph --decorate --color \
    --format="%C(auto)%h%Creset %C(bold blue)%ad%Creset %C(auto)%d%Creset %s" \
    --date=iso $(git rev-list -g --all)\
    '

    if [ ! -f $HOME/.gitconfig ]; then
        echo "Initializing git configuration at \"$HOME/.gitconfig\""
    fi

    if ! git config --global init.defaultBranch >/dev/null; then
        read -rp "Default git branch name (main): " answer
        git config --global init.defaultBranch "''${answer:-main}"
    fi

    if ! git config --global core.editor >/dev/null; then
        read -rp "Default git editor (vim): " answer
        git config --global core.editor "''${answer:-vim}"
    fi

    if ! git config --global user.name >/dev/null; then
        if read -r -p "Git author name: " answer && [ -n "$answer" ]; then
            git config --global user.name "''${answer}"
        fi
    fi

    if ! git config --global user.email >/dev/null; then
        if read -r -p "Git author email: " answer && [ -n "$answer" ]; then
            git config --global user.email "''${answer}"
        fi
    fi

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        read -r -p "No git repo found. Create one now? [Y/n] " answer
        case "''${answer:-Y}" in
            [Yy]*) git init ;;
        esac
    fi

  '';
}
