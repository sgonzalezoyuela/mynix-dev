# JOSSO development environment: tools to work with JOSSO/IAM.tf

{
  description = "JOSSO/IAM.tf project flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    josso-pkgs.url = "github:sgonzalezoyuela/mynix-pkgs";
    myFlakes.url = "git+https://github.com/sgonzalezoyuela/myflakes";
    
  };
  outputs = { self, nixpkgs, flake-utils, josso-pkgs, myFlakes }:
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
          myFlakesPkgs = myFlakes.packages.${system};

        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [
              jdk
              terraform
              jossoctl
              myFlakesPkgs.t
              myFlakesPkgs.ch
              myFlakesPkgs.find-in-jar
              myFlakesPkgs.xclipf
              myFlakesPkgs.vf
              myFlakesPkgs.catf
            ];
          };
        };
      );
}
