{pkgs, ...}: {
  packages = with pkgs; [
    eza
  ];
  enterShell = ''
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -a"
    alias lla="eza -la"
    alias lt="eza -T"
  '';
}
