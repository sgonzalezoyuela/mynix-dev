# in flake.nix

# Prisma with flakes: https://github.com/prisma/prisma/issues/3026#issuecomment-927258138
{
  description = "JOSSO/IAM.tf project flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    josso-pkgs.url = "github:sgonzalezoyuela/mynix-pkgs";
  };
  outputs = { self, nixpkgs, flake-utils, josso-pkgs }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let

          javaVersion = 8;
          overlays = [
            (final: prev: {
              jdk = prev."jdk${toString javaVersion}_headless";
            })
          ];

          pkgs = import nixpkgs {
            inherit overlays system;
          };
          jossoctl = josso-pkgs.packages.${system}.jossoctl;

        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [
              jdk
              terraform
              jossoctl
            ];
          };
        }
      );
}
