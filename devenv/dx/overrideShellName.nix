{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    overrideShellName = {
      enable = lib.mkEnableOption ''
        If devenv.nix is within a git repository,
        the name is set as the location of devenv.nix
        relative to the repo root.

        If no git repository is found,
        then the name is set as the current working directory.

        Providing the text option will override the shell name with that value.
      '';
      prefix = lib.mkOption {
        description = "Text to be prepended to shell name.";
        type = lib.types.str;
        default = "";
      };
      text = lib.mkOption {
        description = "Text to set as the shell name.";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      suffix = lib.mkOption {
        description = "Text to be appended to shell name.";
        type = lib.types.str;
        default = "";
      };
    };
  };
  config = let
    inherit (config.overrideShellName) prefix text suffix;
  in
    lib.mkIf config.overrideShellName.enable {
      enterShell = lib.mkAfter ''
        shell_name() {
            local prefix=${pkgs.lib.escapeShellArg prefix}
            local suffix=${pkgs.lib.escapeShellArg suffix}

            local cwd="$(pwd -P)"
            if git rev-parse --show-toplevel >/dev/null 2>&1; then
                local repo_root="$(git rev-parse --show-toplevel)"

                local relative_path="$(realpath --relative-to="$repo_root" "$cwd")"
                if [ "$relative_path" = "." ]; then
                    local relative_path=""
                else
                    local relative_path="/$relative_path"
                fi

                local infix="$(basename "$repo_root")$relative_path"
            else
                local infix="$cwd"
            fi

            ${
          if text == null
          then ""
          else "local infix=${pkgs.lib.escapeShellArg text}"
        }

            printf %s "$prefix$infix$suffix"
        }

        export name="$(shell_name)"
        unset -f shell_name
      '';
    };
}
