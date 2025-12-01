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
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

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
        };

        vscode = pkgs.vscode-with-extensions.override {
          vscode = pkgs.vscodium;
          vscodeExtensions = [
            syside
          ];
        };
      in
        pkgs.mkShell {
          buildInputs = with pkgs;
            [
              alejandra
            ]
            ++ [vscode];
        }
    );
  };
}
