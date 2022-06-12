{ stdenv
, lib
, fetchurl
}:

let
  pname = "vacuum-card";
  version = "2.6.3";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/denysdovhan/vacuum-card/releases/download/v${version}/vacuum-card.js";
    hash = "sha256-KZmjt3U+OrwUMom4K62p4DzuZfhWcqZuggOr24xcyfs=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -v $src $out/vacuum-card.js
  '';

  meta = with lib; {
    description = "Vacuum cleaner card for Home Assistant Lovelace UI";
    homepage = "https://github.com/denysdovhan/vacuum-card";
    maintainers = with maintainers; [ plabadens ];
    license = licenses.mit;
  };
}
