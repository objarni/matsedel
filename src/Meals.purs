module Meals where

import MealTypes (Meals)
import Data.EuclideanRing ((/))

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
    , unitLess: []
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
    , unitLess: []
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
    , unitLess: []
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
    , unitLess: []
    }
  , { meal: "Kyklingfajitas"
    , ingredients:
        [ { name: "Strimlad kyckling", amount: 150.0, unit: "g" }
        , { name: "Lök", amount: 0.25, unit: "st" }
        , { name: "Röd paprika", amount: 0.25, unit: "st" }
        , { name: "Tortillabröd", amount: 0.25, unit: "paket" }
        , { name: "Avokado", amount: 0.5, unit: "st" }
        , { name: "Lime", amount: 0.25, unit: "st" }
        ]
    , unitLess: [ "Salt" ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/kycklingfajitas-722693/"
    }
  , { meal: "Canneloni"
    , ingredients:
        [ { name: "Fryst spenat", amount: 110.0, unit: "g" }
        , { name: "Mozarella", amount: 0.5, unit: "st" }
        , { name: "Lasagneplatta", amount: 2.0, unit: "st" }
        , { name: "Pastasås", amount: 0.25, unit: "paket" }
        ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/spenat-och-ricottafylld-cannelloni-med-minitomater-713753/"
    , unitLess: [ "Salt" ]
    }
  , { meal: "Tacos"
    , ingredients:
        [ { name: "Tomat", amount: 0.5, unit: "st" }
        , { name: "Kycklingfärs", amount: 125.0, unit: "g" }
        , { name: "Gurka", amount: 0.25, unit: "st" }
        , { name: "Rödlök", amount: 0.25, unit: "st" }
        , { name: "Majsburk", amount: 0.25, unit: "st" }
        , { name: "Isbergssallad", amount: 1.0 / 8.0, unit: "st" }
        , { name: "Tacokrydda", amount: 1.0 / 4.0, unit: "paket" }
        , { name: "Tacoskal eller tortillabröd", amount: 3.0, unit: "st" }
        , { name: "Ost", amount: 0.5, unit: "dl" }
        , { name: "Salsa", amount: 0.5, unit: "dl" }
        , { name: "Gräddfil", amount: 0.5, unit: "dl" }
        ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/tacos-722416/"
    , unitLess: []
    }
  , { meal: "Sagas vegetariska nudlar med ägg"
    , ingredients:
        [ { name: "Ägg", amount: 2.0, unit: "st" }
        , { name: "Nudlar", amount: 1.0, unit: "paket" }
        , { name: "Gurka", amount: 0.25, unit: "st" }
        ]
    , servings: 0
    , webPage: "https://fråga.saga"
    , unitLess: [ "Ost" ]
    }
  , { meal: "Tomatsoppa med pizzabullar"
    , ingredients:
        [ { name: "Färdig pizzadeg", amount: 0.25, unit: "paket" }
        , { name: "Krossade tomater", amount: 0.5, unit: "paket" }
        , { name: "Färdigpastasås", amount: 0.25, unit: "burk" }
        , { name: "Lök", amount: 0.25, unit: "st" }
        , { name: "Grädde", amount: 0.6, unit: "dl" }
        , { name: "Grönsaksbuljong", amount: 0.5, unit: "st" }
        , { name: "Vitlök", amount: 0.25, unit: "st" }
        , { name: "Riven ost", amount: 0.5, unit: "dl" }
        ]
    , servings: 0
    , webPage: "https://fråga.leon"
    , unitLess: []
    }
  , { meal: "Ugnspannkaka med kalkonbacon"
    , ingredients:
        [ { name: "Ägg", amount: 1.5, unit: "st" }
        , { name: "Vetemjöl", amount: 1.0, unit: "dl" }
        , { name: "Mjölk", amount: 2.0, unit: "dl" }
        , { name: "Salt", amount: 0.5, unit: "krm" }
        , { name: "Kalkonbacon", amount: 50.0, unit: "g" }
        , { name: "Smör", amount: 1.0, unit: "msk" }
        ]
    , servings: 0
    , webPage: "https://receptfavoriter.se/recept/ugnspannkaka-med-kalkonbacon"
    , unitLess: ["Lingonsylt"]
    }
  , { meal: "Lax med potatis och citronsås"
    , ingredients:
        [ { name: "Fast potatis", amount: 225.0, unit: "g" }
        , { name: "Citron", amount: 0.25, unit: "st" }
        , { name: "Grädde", amount: 0.75, unit: "dl" }
        , { name: "Majsstärkelse", amount: 0.25, unit: "tsk" }
        , { name: "Haricot verts", amount: 40.0, unit: "g" }
        , { name: "Laxfilé", amount: 1.0, unit: "st" }
        , { name: "Smör", amount: 25.0, unit: "g" }
        ]
    , servings: 0
    , webPage: "https://receptfavoriter.se/recept/ugnspannkaka-med-kalkonbacon"
    , unitLess: ["Salt", "Peppar"]
    }
  ]
--
