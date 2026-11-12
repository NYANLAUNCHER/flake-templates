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

        buildInputs = with pkgs; [
          openssl
          gtk3
          cairo
          pango
          atk
          gdk-pixbuf
          glib
          libsoup_3
          webkitgtk_4_1
          xdotool
        ];

        naersk' = pkgs.callPackage naersk {};
      in rec {
        defaultPackage = naersk'.buildPackage {
          src = ./.;
        };

        devShell = pkgs.mkShell {
          inherit buildInputs;
          nativeBuildInputs = (with pkgs; [
            alejandra
            rust-analyzer-nightly
            dioxus-cli
            pkg-config
          ]) ++ [
            rustToolchain
          ];
          shellHook = ''
            export RUST_BACKTRACE=full
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}"
          '';
        };
      }
    );
}
