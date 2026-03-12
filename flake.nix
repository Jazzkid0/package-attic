{
  description = "package builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, agenix, opencode, ... }:
  let
    system = "x86_64-linux";
  in
  {
    packages.${system} = {
      opencode = opencode.packages.${system}.default;
    };
  };
}
