{
  description = "Meson Project Template";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    ##########################################
    pname = "hello-world";
    version = "0.1.0";
    nativeBuildInputs = with pkgs; [ # build-time dependencies
      pkg-config
      meson ninja
      clang
      just # Use justfiles for project administration
    ];
    buildInputs = with pkgs; [ # runtime dependencies
    ];
    ##########################################
  in {
    defaultPackage.${system} = pkgs.stdenv.mkDerivation {
      inherit pname version buildInputs nativeBuildInputs;
      src = ./.;
      buildPhase = ''
        just build
      '';
      installPhase = ''
        just install
      '';
    };
    devShells.${system}.default = pkgs.mkShell {
      inherit buildInputs;
      # Development Utilities
      nativeBuildInputs = nativeBuildInputs ++ (with pkgs; [
        clang-tools
        lldb gdb valgrind
        unixtools.xxd
        binutils
      ]);
      shellHook = ''
        export pname=${pname}
      '';
    };
  };
}
