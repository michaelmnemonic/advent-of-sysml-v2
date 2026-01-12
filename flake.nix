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
        vscodeExtensions = with pkgs.vscode-extensions;
          [
            mkhl.direnv
            self.packages.${system}.syside
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "geminicodeassist";
              publisher = "google";
              version = "2.64.0";
              sha256 = "sha256-7YDglB8DJFu77BDCoxkij+xXsIuLTPeaUqXoDtAWjVQ=";
            }
            {
              name = "code-spell-checker";
              publisher = "streetsidesoftware";
              version = "4.4.0";
              sha256 = "sha256-4tamHxduWgtGirvS+I6YlYlE3JGzlwDMD21dKaTP9io=";
            }
            {
              name = "code-spell-checker-german";
              publisher = "streetsidesoftware";
              version = "2.3.4";
              sha256 = "sha256-zc0cv4AOswvYcC4xJOq2JEPMQ5qTj9Dad5HhxtNETEs=";
            }
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
      };
      syside-modeler-cli = pkgs.stdenv.mkDerivation {
        pname = "syside-modeler-cli";
        version = "0.8.3";

        src = pkgs.fetchurl {
          url = "https://gitlab.com/api/v4/projects/69960816/packages/generic/syside/0.8.3/syside-0.8.3-x86_64-linux-glibc.tar.xz";
          sha256 = "sha256-C02KlqWg803/xR2651aTsAcnmfFQOCU3+Tc+VKgznXA=";
        };

        sourceRoot = ".";

        nativeBuildInputs = [pkgs.autoPatchelfHook];
        buildInputs = [pkgs.stdenv.cc.cc.lib];

        installPhase = ''
          mkdir -p $out
          cp -r * $out/
        '';
      };
    });
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            alejandra
            self.packages.${system}.syside-modeler-cli
          ];
          shellHook = ''
            alias code='NIXPKGS_ALLOW_UNFREE=1 nix run --impure .#vscode -- '
          '';
        }
    );
  };
}
