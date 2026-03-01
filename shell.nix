# https://github.com/NixOS/nixpkgs/issues/205072
{ pkgs ? import <nixpkgs> { } }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [ ]);
in
pkgs.mkShell {
  packages = [
    pythonEnv
    pkgs.openldap
    pkgs.cyrus_sasl
  ];
}
