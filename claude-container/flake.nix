{
  description = "Template for using Claude Code in Docker container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # Needed since claude-code in unfree software
          config.allowUnfree = true;
        };
        nativeBuildInputs = with pkgs; [ # build-time dependencies
          claude-code
          docker docker-compose
          just # optional, Used for easy project administration
        ];
        buildInputs = with pkgs; [ # runtime dependencies
        ];
      in {
        devShells.default = pkgs.mkShell { inherit nativeBuildInputs buildInputs; };
      });
}
