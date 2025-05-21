{
  description = "Boilerplate flake template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # overlays, see: https://nixos.wiki/wiki/Overlays
        myOverlays = { };
        pkgs = nixpkgs.legacyPackages.${system}.extend (lib.composeManyExtensions myOverlays);
        # dependencies for build environment
        nativeBuildInputs = with pkgs; [ ];
        # runtime dependencies
        buildInputs = with pkgs; [ ];
        drv-common = { # supply common derivation attributes
          pname = "template";
          version = "0.0.0";
          src = ./.;
          inherit nativeBuildInputs;
          inherit buildInputs;
        };
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};

        packages.default = pkgs.stdenv.mkDerivation (drv-common // {
          buildPhase = ''
            echo "Hi from buildPhase!"
          '';
          installPhase = ''
            echo "Hi from installPhase!"
          '';
        });

        packages."dev" = pkgs.stdenv.mkDerivation (drv-common // {
          buildPhase = ''
            echo "Hi from buildPhase!"
          '';
          installPhase = ''
            echo "Hi from installPhase!"
          '';
        });

        apps.default = {
          type = "app";
          program = "${self.packages.default}/bin/${drv-common.pname}";
        };
      }
    );
}
