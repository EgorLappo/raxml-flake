{
  description = "RAxML AVX flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, utils }:
  utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
  in {

    packages.x86_64-linux.raxml = pkgs.stdenv.mkDerivation rec {
      pname = "RAxML";
      version = "8.2.12";

      src = pkgs.fetchFromGitHub {
        owner = "stamatak";
        repo = "standard-RAxML";
        rev = "v${version}";
        sha256 = "1jqjzhch0rips0vp04prvb8vmc20c5pdmsqn8knadcf91yy859fh";
      };

      buildPhase =  ''
        make -f Makefile.AVX.PTHREADS.gcc
      '';

      installPhase = ''
        mkdir -p $out/bin && cp raxmlHPC-PTHREADS-AVX $out/bin
      '';

      meta = {
        description = "A tool for Phylogenetic Analysis and Post-Analysis of Large Phylogenies";
        license = nixpkgs.lib.licenses.gpl3;
        homepage = "https://sco.h-its.org/exelixis/web/software/raxml/";
        platforms = [ "x86_64-linux" ];
      };
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.raxml;

  });
}
