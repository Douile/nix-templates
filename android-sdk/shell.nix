{
  system,
  pkgs ?
    import <nixpkgs> {
      inherit system;
      config.android_sdk.accept_license = true;
      config.allowUnfree = true;
    },
}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "9.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "35.0.1";
    buildToolsVersions = ["34.0.0"];
    includeEmulator = false;
    emulatorVersion = "35.1.5";
    platformVersions = ["21" "33" "34"];
    includeSources = false;
    includeSystemImages = false;
    systemImageTypes = [];
    abiVersions = ["armeabi-v7a" "arm64-v8a"];
    cmakeVersions = ["3.22.1"];
    includeNDK = true;
    ndkVersions = ["26.3.11579264"];
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeExtras = [];
  };
  androidSdk = androidComposition.androidsdk;
  platformTools = androidComposition.platform-tools;
  jdk = pkgs.jdk17;
in
  pkgs.mkShell {
    # create an environment with android SDK manager
    packages = [
      androidSdk
      jdk
      platformTools
    ];

    LANG = "C.UTF-8";
    LC_ALL = "C.UTF-8";
    JAVA_HOME = jdk.home;

    # Note: ANDROID_HOME is deprecated. Use ANDROID_SDK_ROOT.
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";

  }
