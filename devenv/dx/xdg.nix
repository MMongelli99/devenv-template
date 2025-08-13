{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    xdg.enable = lib.mkEnableOption "enables XDG base directories";
    xdg.home = lib.mkOption {
      type = lib.types.str;
      default = ".devenv/state";
    };
  };

  config = lib.mkIf config.xdg.enable {
    enterShell = ''
      export HOME=$(realpath "${config.xdg.home}")
      [ ! -d $HOME ] && mkdir -p $HOME

      export XDG_CACHE_HOME="$HOME/.cache"
      [ ! -d $XDG_CACHE_HOME ] && mkdir -p $XDG_CACHE_HOME

      export XDG_CONFIG_HOME="$HOME/.config"
      [ ! -d $XDG_CONFIG_HOME ] && mkdir -p $XDG_CONFIG_HOME

      export XDG_DATA_HOME="$HOME/.local/share"
      [ ! -d $XDG_DATA_HOME ] && mkdir -p $XDG_DATA_HOME

      export XDG_STATE_HOME="$HOME/.local/state"
      [ ! -d $XDG_STATE_HOME ] && mkdir -p $XDG_STATE_HOME
    '';
  };
}
