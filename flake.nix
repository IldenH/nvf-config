{
  description = "My standalone neovim configuration in nvf";

  inputs = {
    # FIXME: when https://github.com/NixOS/nixpkgs/pull/372019 is in nixos-unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    plugin-blink-emoji = {
      url = "github:moyiz/blink-emoji.nvim";
      flake = false;
    };
    plugin-blink-cmp-spell = {
      url = "github:ribru17/blink-cmp-spell";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;
      pkgsFor = lib.genAttrs systems (system: import nixpkgs { inherit system; });
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    {
      packages = forEachSystem (pkgs: {
        default = pkgs.callPackage ./package.nix {
          inherit inputs;
          colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        };
      });

      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixd
            nixfmt-rfc-style
            statix
          ];
        };
      });
    };
}
