{
  "bing" = {
    metaData = {
      hidden = false;
      alias = "!bing";
    };
  };

  "ddg" = {
    metaData = {
      hidden = false;
      alias = "!ddg";
    };
  };
  "google" = {
    metaData = {
      hidden = false;
      alias = "!google";
    };
  };
  "Home Manager Options" = {
    icon = "https://home-manager-options.extranix.com/images/favicon.png";
    definedAliases = ["!hm"];
    metaData.hidden = true;

    urls = [
      {
        template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
      }
    ];
  };

  "NixOS Wiki" = {
    definedAliases = ["!nw" "!nixwiki"];
    icon = "https://wiki.nixos.org/favicon.ico";
    updateInterval = 24 * 60 * 60 * 1000; # every day
    metaData.hidden = true;

    urls = [
      {
        template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
      }
    ];
  };
  "nixpkgs" = {
    definedAliases = ["!nix"];
    icon = "https://wiki.nixos.org/favicon.ico";

    urls = [
      {
        template = "https://search.nixos.org/packages";
        params = [
          {
            name = "type";
            value = "packages";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
        ];
      }
    ];
  };
}