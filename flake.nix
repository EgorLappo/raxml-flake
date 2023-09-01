{
  description = "RAxML AVX flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {

    packages.x86_64-linux.raxml = pkgs.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.raxml;

  };
}
