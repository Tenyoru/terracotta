#I HATE NIXOS!!!
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    gdalPg = pkgs.gdal.override {
      usePostgres = true;
      useMinimalFeatures = false;
    };

  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        # Core
        pkg-config
        llvmPackages.libclang
        f3d
        osm2pgsql

        postgresql
        postgresqlPackages.postgis

        gdalPg

        python3Packages.psycopg2
      ];

      shellHook = ''
        export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"
        export BINDGEN_EXTRA_CLANG_ARGS="$(pkg-config --cflags gdal)"
        export PATH=$PATH:${pkgs.postgresql}/bin

        echo "✅ Environment ready"
        echo "PostgreSQL: $(psql --version)"
        echo "GDAL: $(gdalinfo --version)"
        gdalinfo --formats | grep PG || echo "⚠️  GDAL PG driver not detected"
      '';
    };
  };
}
