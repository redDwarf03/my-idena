import 'package:my_idena/utils/epoch_period.dart' as EpochPeriod;

class FlipExamples {
  FlipExamples();

  Map<String, dynamic> getMapExample(String typeSession) {
    Map<String, dynamic> mapExemple;
    if (typeSession == EpochPeriod.ShortSession) {
      mapExemple = {
        "jsonrpc": "2.0",
        "id": 19,
        "result": [
          {
            "hash":
                "bafkreial55rw3dirdlrivcjsnnxaswfrloxuk4pbfssxbwhheqbo44crra",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiasdvce4g2wlmkia5bmj27snlsa44imfeu2e5whg3r6rea57avmwa",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiaxmbxoy3rystvl4hcfd46uvbxxqy4op7ivvixhqtf5fvk4vjijpq",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreidipdlvqzvguqpimwi5g72bu4kknrxczitsu2mrrod3ctazfynqem",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiel3bwd35dq64zflh2oxxzh256kl57n2d4n5ezkl3eso7quollm5m",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreiewtcyikpwfrbrbnbmseehqpy3rxozo7fgyihjmck6ltjcxx6yn4q",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "bafkreihs62lgfparrtutsrzup55vpgxx7o7nocakwmcxhojf3fzuen5vqy",
            "ready": true,
            "extra": true,
            "available": true
          },
        ]
      };

      /* mapExemple = {
        "jsonrpc": "2.0",
        "id": 19,
        "result": [
          {
            "hash":
                "bafkreia4khjzwy5kt4k25djgvabdnzz5vi5gvwidk7e5kcvdjdr4x3lygm",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "2",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "3",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "4",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "5",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "6",
            "ready": true,
            "extra": false,
            "available": true
          },
          {
            "hash":
                "7",
            "ready": true,
            "extra": true,
            "available": true
          },
        ]
      };*/

    } else {
      if (typeSession == EpochPeriod.LongSession) {
        mapExemple = {
          "jsonrpc": "2.0",
          "id": 19,
          "result": [
            {
              "hash":
                  "bafkreia4khjzwy5kt4k25djgvabdnzz5vi5gvwidk7e5kcvdjdr4x3lygm",
              "ready": true,
              "extra": false,
              "available": true
            },
            {"hash": "2", "ready": true, "extra": false, "available": true},
            {"hash": "3", "ready": true, "extra": false, "available": true},
            {"hash": "4", "ready": true, "extra": false, "available": true},
            {"hash": "5", "ready": true, "extra": false, "available": true},
            {"hash": "6", "ready": true, "extra": false, "available": true},
            {"hash": "7", "ready": true, "extra": true, "available": true},
            {
              "hash":
                  "bafkreial55rw3dirdlrivcjsnnxaswfrloxuk4pbfssxbwhheqbo44crra",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreiasdvce4g2wlmkia5bmj27snlsa44imfeu2e5whg3r6rea57avmwa",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreiaxmbxoy3rystvl4hcfd46uvbxxqy4op7ivvixhqtf5fvk4vjijpq",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreidipdlvqzvguqpimwi5g72bu4kknrxczitsu2mrrod3ctazfynqem",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreiel3bwd35dq64zflh2oxxzh256kl57n2d4n5ezkl3eso7quollm5m",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreiewtcyikpwfrbrbnbmseehqpy3rxozo7fgyihjmck6ltjcxx6yn4q",
              "ready": true,
              "extra": false,
              "available": true
            },
            {
              "hash":
                  "bafkreihs62lgfparrtutsrzup55vpgxx7o7nocakwmcxhojf3fzuen5vqy",
              "ready": true,
              "extra": true,
              "available": true
            },
          ]
        };
      }
    }
    return mapExemple;
  }
}
