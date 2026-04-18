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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, agenix, opencode, fenix, ... }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    lib = pkgs.lib;
  in
  {
    packages.x86_64-linux = {
      opencode = opencode.packages.x86_64-linux.default;
      agenix = agenix.packages.x86_64-linux.default;
      fenix = fenix.packages.x86_64-linux.default.toolchain;
      rust-analyzer = pkgs.rust-analyzer;
    };

    apps.x86_64-linux = {
      build-all = {
        type = "app";
        meta = {
          description = "build all of the packages in this flake";
        };
        program = (pkgs.writeShellScriptBin "build-all" ''
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: _: "nix build --no-link --print-out-paths .#${name}") self.packages.x86_64-linux)}
        '').outPath + "/bin/build-all";
      };
    };
  };
}
