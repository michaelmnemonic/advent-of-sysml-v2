{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system}.pkgs;
    in {
      vscode = pkgs.vscode-with-extensions.override {
          vscodeExtensions = [
            self.packages.${system}.syside
          ];
        };
        syside = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "syside-editor";
            publisher = "sensmetry";
            version = "0.8.3";
            sha256 = "sha256-mZGtB1BaeVIR4K/cT0elpfW7zrQBFScVHHOsHIuKvJg=";
            arch = "linux-x64";
          };
          nativeBuildInputs = [pkgs.autoPatchelfHook];
          buildInputs = [pkgs.stdenv.cc.cc.lib];
          # installPhase = ''
          #   tar -xJf ../syside-0.8.3-x86_64-linux-glibc.tar.xz -C $out/share/vscode/extensions/sensmetry.syside-editor/dist
          # '';
        };
    });
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

      in
        pkgs.mkShell {
          buildInputs = with pkgs;
            [
              alejandra
            ];
          shellHook = ''
            alias code='NIXPKGS_ALLOW_UNFREE=1 nix run --impure .#vscode -- '
          '';
        }
    );
  };
}
