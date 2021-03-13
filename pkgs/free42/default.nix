{ stdenv, fetchFromGitHub, makeDesktopItem, gtk3, alsaLib, pkg-config}:

stdenv.mkDerivation rec {
  pname = "free42";
  version = "3.0.1";

  src = fetchFromGitHub{
    owner = "thomasokken";
    repo = "free42";
    rev = "v${version}";
    sha256 = "14prfykh57rad6hkcb99980sg2xnajqfnwa4v6vbwm0qg0s3dn8y";
  };

  desktopItem = makeDesktopItem {
    name = "Free42";
    desktopName = "Free42";
    genericName = "Calculator";
    exec = "free42dec";
    icon = "free42dec";
    type = "Application";
    comment = meta.description;
    categories = "Science";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gtk3 alsaLib ];
  sourceRoot = "source/gtk";

  enableParallelBuilding = true;

  patchPhase = ''
    substituteInPlace Makefile --replace /bin/ls ls
  '';

  makeFlags = [ "BCD_MATH=1" "AUDIO_ALSA=1" ];

  installPhase = ''
    install -D -m 755 free42dec $out/bin/free42dec
    install -D -m 755 icon-128x128.xpm $out/share/pixmaps/free42dec.xpm

    mkdir -p $out/share
    cp -rv ${desktopItem}/share/applications $out/share/
  '';

  meta = with stdenv.lib; {
    description = "An HP-42S Calculator Simulator";
    homepage = "https://thomasokken.com/free42";
    license = licenses.gpl2;
    platforms = platforms.all;
  };
}