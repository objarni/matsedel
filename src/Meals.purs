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
    , nonQuantifiableIngredients: [ "Salt", "Citronpeppar" ]
    , servings: 2
    , webPage: "https://www.mathem.se/recept/lax-i-ugn-med-rotfrukter-och-fetaost"
    }
  , { meal: "Äggröra med fetaost och pasta"
    , ingredients:
        [ { name: "Grädde", amount: 0.25, unit: "dl" }
        , { name: "Ägg", amount: 2.0, unit: "st" }
        , { name: "Fetaost", amount: 25.0, unit: "g" }
        , { name: "Pasta", amount: 100.0, unit: "g" }
        ]
    , nonQuantifiableIngredients: [ "Salt", "Peppar", "Smör" ]
    , servings: 0
    , webPage: "https://www.elinaomickesmat.se/kramig-aggrora-med-fetaost/"
    }
  ]

