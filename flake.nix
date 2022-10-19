{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.default = self.packages.${system}.steno-dictionaries;

      packages.steno-dictionaries =
        let
          dicts = import ./dictionaries.nix { inherit pkgs; };

          inherit (nixpkgs) lib;
          digits = builtins.stringLength (builtins.toString (builtins.length dicts));
        in
        pkgs.runCommand "steno-dictionaries" { } ''
          mkdir -p $out
          ${lib.strings.concatImapStringsSep "\n" (index: dict: "cp ${dict} $out/${lib.strings.fixedWidthNumber digits index}_${builtins.baseNameOf dict}") dicts}
        '';

      formatter = pkgs.nixpkgs-fmt;
    });
}
