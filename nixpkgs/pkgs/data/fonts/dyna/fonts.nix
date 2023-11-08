{ lib, fetchurl }:

let
  version = "2022-02-06";
in
{
  dfheilight-b5 = fetchurl {
    name = "DFHeiLight-B5-${version}";

    url = "https://gist.github.com/DFHeiLight-B5.ttc";

    downloadToTemp = true;
    recursiveHash = true;

    postFetch = ''
      install -m444 -Dt $out/share/fonts/truetype $downloadedFile
    '';

    sha256 = "sha256-07DJVac6QpKRGARpEj+/3ta/PC9rU8//pb64nPNoNpg=";

    meta = with lib; {
      description = "DFHeiLight-B5";
      maintainers = with maintainers; [ user ];
      platforms = platforms.all;
    };
  };

  dfheimedium-b5 = fetchurl {
    name = "DFHeiMedium-B5-${version}";

    url = "https://gist.github.com/DFHeiMedium-B5.ttc";

    downloadToTemp = true;
    recursiveHash = true;

    postFetch = ''
      install -m444 -Dt $out/share/fonts/truetype $downloadedFile
    '';

    sha256 = "sha256-e1WTELbqlHGbpJv2V3A93yop1kLuW0Hf4P5UZpROGxs=";

    meta = with lib; {
      description = "DFHeiMedium-B5";
      maintainers = [ maintainers.user ];
      platforms = platforms.all;
    };
  };
}

