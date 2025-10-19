model_path := "model.obj"

build:
  cargo build
run:
  cargo build
  cargo run

setup:

develop:
  nix develop -c fish
see:
  f3d --watch {{model_path}} &
