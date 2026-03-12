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
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    lib = pkgs.lib;
  in
  {
    packages.x86_64-linux = {
      opencode = opencode.packages.x86_64-linux.default;
      agenix = agenix.packages.x86_64-linux.default;
    };

    apps.x86_64-linux = {
      build-all = {
        type = "app";
        program = (pkgs.writeShellScriptBin "build-all" ''
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: _: "nix build --no-link --print-out-paths .#${name}") self.packages.x86_64-linux)}
        '').outPath + "/bin/build-all";
      };
    };
  };
}
