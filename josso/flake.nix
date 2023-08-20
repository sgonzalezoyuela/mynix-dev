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
          pkgs = import nixpkgs {
            inherit system;
          };
          jpkgs = import josso-pkgs {
            inherit system;
          };
        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [
              terraform
              jpkgs.jossoctl
            ];
          };
        }
      );
}
