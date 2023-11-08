{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "monaco-nerd";
  version = "2022-08-21";

  src = fetchFromGitHub {
    owner = "Karmenzind";
    repo = "monaco-nerd-fonts";
    rev = "e656895b7894858f6a0341ad783ac1ec0959f5eb";
    sha256 = "sha256-r1LE/qQe2J5r07WXHJmIIKyvgnyrn1WKl6f1IrlnVH4=";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/Monaco

    # Monaco
    cp "fonts/Monaco Nerd Font Complete Mono Windows Compatible.otf" $out/share/fonts/opentype/Monaco
    cp "fonts/Monaco Nerd Font Complete Mono.otf" $out/share/fonts/opentype/Monaco
    cp "fonts/Monaco Nerd Font Complete Windows Compatible.otf" $out/share/fonts/opentype/Monaco
    cp "fonts/Monaco Nerd Font Complete.otf" $out/share/fonts/opentype/Monaco
  '';

  meta = with lib; {
    homepage = "https://developer.apple.com/fonts/";
    description = "Monaco font with Nerd Font patch";
    maintainers = with maintainers; [ user ];
    platforms = platforms.all;
  };
}
