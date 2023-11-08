{ lib
, stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation rec {
  pname = "microsoft-fonts";
  version = "2022-02-05";

  mingliu = fetchurl {
    url =
      "https://github.com/ntu-student-congress/tortue/raw/c8a0d273bebc63aa2bcac0d27f3f20361f3575dc/fonts/PMingLiU.ttf";
    sha256 = "sha256-u5G/Vcf1pxkbGS0zpQGqnA3+gMRJRLLkkoNagYjR+Mw=";
  };

  dfkai-sb = fetchurl {
    url =
      "https://github.com/ntu-student-congress/tortue/raw/c8a0d273bebc63aa2bcac0d27f3f20361f3575dc/fonts/kaiu.ttf";
    sha256 = "sha256-nll6OR2GmgUmosGtFHFBk6uxvZ59hXOPnOzkEQGCKbc=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    # PMingLiU
    install -Dm644 ${mingliu} $out/share/fonts/truetype/microsoft/PMingLiU.ttf

    # DFKai-SB
    install -Dm644 ${dfkai-sb} $out/share/fonts/truetype/microsoft/DFKai-SB.ttf
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-L3Rgt4Ggxq6NtQ5ShvQpAjaPlxmeBz/6+znR7GYyzgE=";

  meta = with lib; {
    homepage = "https://docs.microsoft.com/en-us/typography/fonts/windows_10_font_list";
    description = "Fonts by Microsoft";
    maintainers = with maintainers; [ user ];
    platforms = platforms.all;
  };
}
