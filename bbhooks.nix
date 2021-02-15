{ lib, buildPythonPackage, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "bbhooks";
  version = "0.0.1";

  src = fetchFromGitHub {
        owner = "rpgwaiter";
        repo = "basedbuildhooks";
        rev = ver;
        sha256 = "";
    };

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/rpgwaiter/basedbuildhooks";
    description = "Automatic NixOS builds via webhooks";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rpgwaiter ];
  };
}