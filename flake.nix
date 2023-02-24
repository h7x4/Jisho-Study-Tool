{
  description = "A dictionary app for studying japanese";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";

    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-dart = {
      url = "github:tadfisher/nix-dart";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, android-nixpkgs, nix-dart }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        android_sdk.accept_license = true;
        allowUnfree = true;
      };
    };
  in {
    packages.${system} = {
      android-sdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
        cmdline-tools-latest
        build-tools-33-0-0
        build-tools-32-0-0
        build-tools-31-0-0
        build-tools-30-0-2
        build-tools-29-0-2
        platform-tools
        platforms-android-33
        platforms-android-32
        platforms-android-31
        platforms-android-30
        platforms-android-29
        emulator
      ]);
    };

    devShell.${system} = let
      inherit (pkgs) lcov google-chrome sqlite sqlite-web flutter dart;
      jdk = pkgs.jdk11;

      inherit (self.packages.${system}) android-sdk;
      inherit (nix-dart.packages.${system}) pub2nix-lock;
    in pkgs.mkShell rec {
      ANDROID_JAVA_HOME="${jdk.home}";
      ANDROID_SDK_ROOT = "${android-sdk}/share/android-sdk";
      CHROME_EXECUTABLE = "${google-chrome}/bin/google-chrome-stable";
      FLUTTER_SDK="${flutter}";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/33.0.0/aapt2";
      JAVA_HOME="${ANDROID_JAVA_HOME}";
      USE_CCACHE=0;

      buildInputs = [
        android-sdk
        dart
        flutter
        google-chrome
        jdk
        lcov
        pub2nix-lock
        sqlite
        sqlite-web
      ];
    };
  };
}
