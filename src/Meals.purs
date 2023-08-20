module Meals where

import MealTypes (Meals)

standardMatsedel :: Meals
standardMatsedel =
  [ { meal: "Stekt lax med rotfrukter i ugn"
    , ingredients:
        [ { name: "Laxfilé", amount: 1.0, unit: "st" }
        , { name: "Fast potatis", amount: 1.0, unit: "st" }
        , { name: "Morot", amount: 1.0, unit: "st" }
        , { name: "Sötpotatis", amount: 1.0, unit: "st" }
        , { name: "Rödlök", amount: 0.5, unit: "st" }
        , { name: "Vitlök", amount: 2.25, unit: "st" }
        , { name: "Olivolja", amount: 0.5, unit: "msk" }
        , { name: "Smör", amount: 1.0, unit: "msk" }
        , { name: "Yoghurt", amount: 0.4, unit: "dl" }
        , { name: "Fetaost", amount: 40.0, unit: "g" }
        , { name: "Örter", amount: 0.25, unit: "dl" }
        ]
    , servings: 0
    , webPage: "https://www.mathem.se/recept/lax-i-ugn-med-rotfrukter-och-fetaost"
    }
  , { meal: "Äggröra med fetaost och pasta"
    , ingredients:
        [ { name: "Grädde", amount: 0.25, unit: "dl" }
        , { name: "Ägg", amount: 2.0, unit: "st" }
        , { name: "Fetaost", amount: 25.0, unit: "g" }
        , { name: "Pasta", amount: 100.0, unit: "g" }
        ]
    , servings: 0
    , webPage: "https://www.elinaomickesmat.se/kramig-aggrora-med-fetaost/"
    }
  , { meal: "Blocktorsk i ugn med ris och sås"
    , ingredients:
        [ { name: "Ris", amount: 0.75, unit: "dl" }
        , { name: "Torsk", amount: 150.0, unit: "g" }
        , { name: "Smaksatt Creme Fraiche", amount: 0.75, unit: "dl" }
        , { name: "Grädde", amount: 0.75, unit: "dl" }
        ]
    , servings: 0
    , webPage: "https://www.elinaomickesmat.se/kramig-aggrora-med-fetaost/"
    }
  , { meal: "Flygande Jacob"
    , ingredients:
        [ { name: "Kycklingfilé", amount: 125.0, unit: "g" }
        , { name: "Kycklingbacon", amount: 35.0, unit: "g" }
        , { name: "Banan", amount: 0.25, unit: "st" }
        , { name: "Jordnötter", amount: 0.5, unit: "dl" }
        , { name: "Grädde", amount: 0.75, unit: "dl" }
        , { name: "Chilisås", amount: 0.25, unit: "dl" }
        , { name: "Ris", amount: 0.75, unit: "dl" }
        ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/flygande-jacob-717569/"
    }
  , { meal: "Kyklingfajitas"
    , ingredients:
        [ { name: "Kycklingfilé", amount: 1.0, unit: "g" }
        , { name: "Lök", amount: 0.25, unit: "st" }
        , { name: "Röd paprika", amount: 0.25, unit: "st" }
        , { name: "Tortillabröd", amount: 0.25, unit: "paket" }
        , { name: "Avokado", amount: 0.5, unit: "st" }
        , { name: "Lime", amount: 0.25, unit: "st" }
        , { name: "Koriander", amount: 0.0, unit: "st" }
        ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/kycklingfajitas-722693/"
    }
  ]
