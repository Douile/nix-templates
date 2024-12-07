{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/mobile/androidenv/examples/shell-without-emulator.nix
  description = "A shell with android SDK manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    # system should match the system you are running on
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.android_sdk.accept_license = true;
      config.allowUnfree = true;
    };
  in {
    devShells."${system}".default = import ./shell.nix {
      inherit system;
      inherit pkgs;
    };
    #devShells."${system}".default = self.devSells."${system}".androidSDK;

    formatter."${system}" = pkgs.alejandra;
  };
}
