{
  description = "A dictionary app for studying japanese";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-dart = {
      url = "github:tadfisher/nix-dart";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-flutter = {
    #   url = "path:/home/h7x4/git/flutter_linux_2.5.1-stable/flutter";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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

    dartVersion = "2.14.2";
    dartChannel = "stable";

    flutterVersion = "2.5.1";
    flutterChannel = "stable";
  in {

    packages.${system} = {
      android-sdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
        cmdline-tools-latest
        build-tools-32-0-0
        build-tools-31-0-0
        build-tools-30-0-2
        build-tools-29-0-2
        platform-tools
        platforms-android-32
        platforms-android-31
        platforms-android-30
        platforms-android-29
        emulator
      ]);

      # dart = nix-dart.packages.${system}.dart;
      dart = (pkgs.callPackage ./nix/dart.nix {});

      inherit (pkgs.callPackage ./nix/flutter.nix { inherit (self.packages.${system}) dart; }) flutter;

      # pub2nix-lock = nix-dart.packages.${system}.pub2nix-lock;
    };

    # apps.${system} = {
    #   web-debug = {
    #     type = "app";
    #     program = "";
    #   };
    #   web-release = {
    #     type = "app";
    #     program = "";
    #   };
    #   apk-debug = {
    #     type = "app";
    #     program = "";
    #   };
    #   apk-release = {
    #     type = "app";
    #     program = "${self.packages.${system}.flutter}/bin/flutter run --release";
    #   };
    #   default = self.apps.${system}.apk-debug;
    # };

    devShell.${system} = let
      inherit (pkgs) lcov google-chrome sqlite sqlite-web;
      inherit (self.packages.${system}) android-sdk flutter dart;
      inherit (nix-dart.packages.${system}) pub2nix-lock;
      java = pkgs.jdk8;
    in pkgs.mkShell rec {
      ANDROID_JAVA_HOME="${java.home}";
      ANDROID_SDK_ROOT = "${android-sdk}/share/android-sdk";
      CHROME_EXECUTABLE = "${google-chrome}/bin/google-chrome-stable";
      FLUTTER_SDK="${flutter}";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/32.0.0/aapt2";
      JAVA_HOME="${ANDROID_JAVA_HOME}";
      USE_CCACHE=0;

      buildInputs = [
        android-sdk
        dart
        flutter
        google-chrome
        java
        lcov
        pub2nix-lock
        sqlite
        sqlite-web
      ];
    };
  };
}
