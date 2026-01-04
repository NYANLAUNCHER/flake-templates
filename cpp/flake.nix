{
  description = "C++ Template";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    ##########################################
    pname = "hello-world";
    version = "0.1.0";
    nativeBuildInputs = with pkgs; [ # build-time dependencies
      pkg-config autoconf automake gcc rsync
    ];
    buildInputs = with pkgs; [ # runtime dependencies
    ];
    ##########################################
  in {
    defaultPackage.${system} = pkgs.stdenv.mkDerivation {
      inherit pname version buildInputs nativeBuildInputs;
      src = ./.;
      buildPhase = ''
        make
      '';
      installPhase = ''
        make install
      '';
    };
    devShells.${system}.default = pkgs.mkShell {
      inherit buildInputs;
      nativeBuildInputs = nativeBuildInputs ++ (with pkgs; [
        # dev-shell utils
        lldb gdb
        unixtools.xxd
      ]);
      shellHook = ''
        export pname=${pname}
      '';
    };
  };
}
