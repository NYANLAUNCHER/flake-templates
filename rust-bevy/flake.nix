{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
  };

  outputs = {
    self,
    flake-utils,
    naersk,
    nixpkgs,
    fenix,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = (import nixpkgs) {
          inherit system;
          overlays = [fenix.overlays.default];
        };

        rustToolchain = with pkgs.fenix; combine [
          (with complete; [
            cargo 
            clippy 
            rust-src 
            rustc 
            rustfmt
          ])
          # Add build targets
          targets.wasm32-unknown-unknown.latest.rust-std
        ];

        # Buildtime dependencies
        nativeBuildInputs = (with pkgs; [
          alejandra
          pkg-config
          rust-analyzer-nightly
        ]) ++ [
          rustToolchain
        ];

        # Runtime dependencies
        buildInputs = with pkgs; [
          glib
          openssl
        ];

        naersk' = pkgs.callPackage naersk {};
      in rec {
        defaultPackage = naersk'.buildPackage {
          inherit buildInputs nativeBuildInputs;
          src = ./.;
        };

        devShell = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
          shellHook = ''
            export RUST_BACKTRACE=full
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}"
          '';
        };
      }
    );
}
