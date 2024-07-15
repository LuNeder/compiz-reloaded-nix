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
      compiz = final.callPackage ./. { python3 = pkgs.python311; python3Packages = pkgs.python311Packages; };
    };

    packages = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      default = compiz;
      compiz = pkgs.callPackage ./. { python3 = pkgs.python311; python3Packages = pkgs.python311Packages; };
    });
  };
}
