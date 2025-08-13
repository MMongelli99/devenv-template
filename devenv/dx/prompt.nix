{pkgs, ...}: {
  packages = with pkgs; [starship];
  enterShell = ''
    eval "$(starship init bash)"
    starship preset plain-text-symbols -o "$XDG_CONFIG_HOME/starship.toml"
  '';
}
