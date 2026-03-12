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
  {
    packages.x86_64-linux = {
      opencode = opencode.packages.x86_64-linux.default;
      agenix = agenix.packages.x86_64-linux.default;
    };
  };
}
