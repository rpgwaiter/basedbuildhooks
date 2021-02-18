{   lib
  , stdenv
  , buildPythonPackage
  , fetchFromGitHub
  , python39
  , pkg-config
}:

let
  bbhooks = python39.pkgs.buildPythonPackage rec {
    pname = "bbhooks";
    version = "0.0.1";

    src = fetchFromGitHub {
      owner = "rpgwaiter";
      repo = "basedbuildhooks";
      rev = version;
      sha256 = "";
    };

    doCheck = false;

    buildInputs = [ flask ];

    nativeBuildInputs = [
      pkg-config
    ];

    meta = {
      homepage = "https://github.com/rpgwaiter/basedbuildhooks";
      description = "Automatic NixOS builds via webhooks";
      license = licenses.gpl3Plus;
    };
  };

in python39.withPackages (ps: [ps.flask bbhooks])
