{
  description = "Your new project, powered by flake-parts!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... } @ inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    # Declared systems that your flake supports. These will be enumerated in perSystem
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

    # Import flake modules
    imports = [
      # ./module.nix
      # inputs.foo.flakeModule
    ];

    perSystem = { config, self', inputs', pkgs, system, ... }: {
      # Allows definition of system-specific attributes
      # without needing to declare the system explicitly!
      #
      # Quick rundown of the provided arguments:
      # - config is a reference to the full configuration, lazily evaluated
      # - self' is the outputs as provided here, without system. (self'.packages.default)
      # - inputs' is the input without needing to specify system (inputs'.foo.packages.bar)
      # - pkgs is an instance of nixpkgs for your specific system
      # - system is the system this configuration is for

      # This is equivalent to packages.<system>.default
      packages.default = pkgs.hello;

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [];
        nativeBuildInputs = with pkgs; [
          hello
        ];
        shellHook = ''
          hello
        '';
      };
    };

    flake = {
      # The usual flake attributes can be defined here, including
      # system-agnostic and/or arbitrary outputs.
    };
  };
}
