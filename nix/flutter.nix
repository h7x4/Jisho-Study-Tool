{ flutterPackages, fetchurl, dart }:
let
  dartVersion = "2.16.2";
  flutterVersion = "2.10.5";

  channel = "stable";
  filename = "flutter_linux_${flutterVersion}-${channel}.tar.xz";

  getPatches = dir:
    let files = builtins.attrNames (builtins.readDir dir);
    in map (f: dir + ("/" + f)) files;
in
{
  flutter = flutterPackages.mkFlutter {
    version = flutterVersion;
    inherit dart;
    pname = "flutter";
    src = fetchurl {
      url = "https://storage.googleapis.com/flutter_infra_release/releases/${channel}/linux/${filename}";
      sha256 = "DTZwxlMUYk8NS1SaWUJolXjD+JnRW73Ps5CdRHDGnt0=";
    };
    patches = getPatches ./flutter_patches;
  };
}
