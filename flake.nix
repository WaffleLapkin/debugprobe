# This is a simple nix flake which provides a dev shell for debugprobe development on on NixOS.
# You can either use `nix develop` to activate it manually or [`direnv`] to activate it automatically.
#
# [`direnv`]: https://github.com/nix-community/nix-direnv

{
  description = "dev shell for `debugprobe`";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forEachSystem = lib.genAttrs lib.systems.flakeExposed;
      pkgs = nixpkgs;
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.pkgs;
        in
        {
          default = pkgs.mkShell {
            name = "debugprobe-shell";
            packages = [
              pkgs.python3
              pkgs.git-lfs
              pkgs.cmake
              pkgs.gnumake
              pkgs.gcc-arm-embedded-13
              pkgs.picotool
            ];
          };
        }
      );
    };
}
