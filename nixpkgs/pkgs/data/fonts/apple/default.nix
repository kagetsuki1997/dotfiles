{ stdenv, lib, fetchurl, fetchFromGitHub, cpio, gzip, undmg, xar }:

let
  monaco = fetchFromGitHub {
    owner = "todylu";
    repo = "monaco.ttf";
    rev = "d258639b562cab674da79e9e3316998e709e8960";
    sha256 = "sha256-aUkI8BUJ1wXj9mPyK8WvpzpUfT8UbVsbAxKB9QKwtk0=";
  };

  sf-pro = fetchurl {
    url =
      "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-nkuHge3/Vy8lwYx9z+pvsQZfzrNIP4K0OutpPl4yXn0=";
  };

  sf-compact = fetchurl {
    url =
      "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-+Q4HInJBl3FLb29/x9utf7A55uh5r79eh/7hdQDdbSI=";
  };

  sf-mono = fetchurl {
    url =
      "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-pqkYgJZttKKHqTYobBUjud0fW79dS5tdzYJ23we9TW4=";
  };

  ny = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-XOiWc4c7Yah+mM7axk8g1gY12vXamQF78Keqd3/0/cE=";
  };

in
stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "2020-07-13";

  srcs = [ monaco sf-pro sf-compact sf-mono ny ];
  sourceRoot = ".";

  nativeBuildInputs = [ cpio gzip undmg xar ];
  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/Monaco

    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/doc/${pname}

    # Monaco
    cp source/monaco.ttf $out/share/fonts/truetype/Monaco

    # SF Pro
    xar -xf "SF Pro Fonts.pkg"
    cat SFProFonts.pkg/Payload | gunzip -dc | cpio -idm
    mv Library/Fonts $out/share/fonts/opentype/SF\ Pro

    # SF Compact
    xar -xf "SF Compact Fonts.pkg"
    cat SFCompactFonts.pkg/Payload | gunzip -dc | cpio -idm
    mv Library/Fonts $out/share/fonts/opentype/SF\ Compact

    # SF Mono
    xar -xf "SF Mono Fonts.pkg"
    cat SFMonoFonts.pkg/Payload | gunzip -dc | cpio -idm
    mv Library/Fonts $out/share/fonts/opentype/SF\ Mono

    # NY
    xar -xf "NY Fonts.pkg"
    cat NYFonts.pkg/Payload | gunzip -dc | cpio -idm
    mv Library/Fonts $out/share/fonts/opentype/NY
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-fTB7JrWIvmFPjggDGmyTpWd8phNr6kMPaQKuz09FQ2k=";

  meta = with lib; {
    homepage = "https://developer.apple.com/fonts/";
    description = "Fonts by Apple Inc.";
    maintainers = with maintainers; [ user ];
    platforms = platforms.all;
  };
}
