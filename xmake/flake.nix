{
  description = "Xmake Project Template";

  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    # For more information about the C/C++ infrastructure in nixpkgs: https://wiki.nixos.org/wiki/C
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pname = "hello-world"; # package name
        version = "0.0.1";
        src = ./.;
        nativeBuildInputs = with pkgs; [ # build-time dependencies
          pkg-config
          xmake
          clang
        ];
        buildInputs = with pkgs; [ # runtime dependencies
        ];
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          inherit buildInputs nativeBuildInputs pname version src;
          buildPhase = ''
            xmake build
          '';
          installPhase = ''
            xmake install
          '';
        };
        devShells.default = pkgs.mkShell {
          inherit buildInputs;
          nativeBuildInputs = nativeBuildInputs ++ (with pkgs; [
            # Development Utilities
            clang-tools
            lldb gdb valgrind
            unixtools.xxd
            binutils
          ]);
          shellHook = ''
            export pname=${pname}
          '';
        };
      });
}
