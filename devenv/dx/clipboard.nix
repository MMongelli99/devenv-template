{pkgs, ...}: {
  packages =
    if pkgs.stdenv.isDarwin
    then
      with pkgs; [
        (writeShellScriptBin "pbcopy" ''exec /usr/bin/pbcopy "$@"'')
        (writeShellScriptBin "pbpaste" ''exec /usr/bin/pbpaste "$@"'')
      ]
    else if pkgs.stdenv.isLinux
    then
      with pkgs; [
        wl-clipboard
        xclip
      ]
    else [];
}
