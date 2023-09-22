{
  description = "RAxML AVX flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {

        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "RAxML";
          version = "8.2.12";

          src = pkgs.fetchFromGitHub {
            owner = "stamatak";
            repo = "standard-RAxML";
            rev = "v${version}";
            sha256 = "1jqjzhch0rips0vp04prvb8vmc20c5pdmsqn8knadcf91yy859fh";
          };

          buildInputs = [
            pkgs.gcc
          ];

          buildPhase = ''
            make -f Makefile.AVX.PTHREADS.gcc
          '';

          installPhase = ''
            mkdir -p $out/bin && cp raxmlHPC-PTHREADS-AVX $out/bin
          '';
        };

      });
}
