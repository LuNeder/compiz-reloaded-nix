{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  }: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    overlays.default = final: prev: {
      compiz-reloaded = final.callPackage ./. {};
    };

    packages = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      default = compiz-reloaded;
      compiz-reloaded = pkgs.callPackage ./. {};
    });
  };
}
