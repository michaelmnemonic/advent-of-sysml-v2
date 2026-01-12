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
      syside_version = "0.8.3";
    in {
      vscode = pkgs.vscode-with-extensions.override {
        vscodeExtensions = with pkgs.vscode-extensions;
          [
            mkhl.direnv
            self.packages.${system}.syside-vscode-extension
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
      syside-vscode-extension = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "syside-editor";
          publisher = "sensmetry";
          version = syside_version;
          sha256 = "sha256-mZGtB1BaeVIR4K/cT0elpfW7zrQBFScVHHOsHIuKvJg=";
          arch = "linux-x64";
        };
      };
      syside-modeler-cli = pkgs.stdenv.mkDerivation {
        pname = "syside-modeler-cli";
        version = syside_version;

        src = pkgs.fetchurl {
          url = "https://gitlab.com/api/v4/projects/69960816/packages/generic/syside/${syside_version}/syside-${syside_version}-x86_64-linux-glibc.tar.xz";
          sha256 = "sha256-C02KlqWg803/xR2651aTsAcnmfFQOCU3+Tc+VKgznXA=";
        };

        sourceRoot = ".";

        nativeBuildInputs = [pkgs.autoPatchelfHook];
        buildInputs = [];

        installPhase = ''
          mkdir -p $out
          cp -r * $out/
        '';
      };
      syside-python-package = pkgs.python3Packages.buildPythonPackage rec {
        pname = "syside";
        version = syside_version;

        src = pkgs.fetchurl {
          # FIXME: use fetchPypi?
          url = "https://files.pythonhosted.org/packages/fc/1d/e5b277fe50fb8aa605ed5e3b355763bb5134c54ca8bbb254ad66f9b63ad9/syside-0.8.3-cp312-abi3-manylinux_2_31_x86_64.whl";
          hash = "sha256-M5WOp1e+BumjXWlILPXQqlWr9M2PgLM/tjblLBmund0=";
          #format = "wheel";
          #python = "cp312";
          #abi = "abi3";
          #platform = "manylinux_2_31_x86_64";
        };
        # do not run tests
        doCheck = false;
        dontBuild = true;

        # specific to buildPythonPackage, see its reference
        pyproject = true;
        build-system = with pkgs.python3Packages; [
          setuptools
          wheel
        ];
      };
    });
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            alejandra
            #(python3.withPackages (python-pkgs: [
            #  self.packages.${system}.syside-python-package
            #]))
            self.packages.${system}.syside-modeler-cli
          ];
          shellHook = ''
            alias code='NIXPKGS_ALLOW_UNFREE=1 nix run --impure .#vscode -- '
          '';
        }
    );
  };
}
