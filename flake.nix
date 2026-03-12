{
  description = "package builder";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, agenix }:
  {
  };
}
