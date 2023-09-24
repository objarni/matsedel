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
  , { meal: "Billig tomatsoppa"
    , ingredients:
        [ { name: "Krossade tomater", amount: 0.5, unit: "paket" }
        , { name: "Lök", amount: 0.25, unit: "st" }
        , { name: "Grädde", amount: 0.6, unit: "dl" }
        , { name: "Grönsaksbuljong", amount: 0.5, unit: "st" }
        , { name: "Vitlök", amount: 0.25, unit: "st" }
        ]
    , servings: 0
    , webPage: "https://fråga.josefin"
    , unitLess: []
    }
  , { meal: "Ugnspannkaka med kalkonbacon"
    , ingredients:
        [ { name: "Ägg", amount: 1.5, unit: "st" }
        , { name: "Vetemjöl", amount: 1.0, unit: "dl" }
        , { name: "Mjölk", amount: 0.2, unit: "l" }
        , { name: "Salt", amount: 0.5, unit: "krm" }
        , { name: "Kalkonbacon", amount: 50.0, unit: "g" }
        , { name: "Smör", amount: 1.0, unit: "msk" }
        ]
    , servings: 0
    , webPage: "https://receptfavoriter.se/recept/ugnspannkaka-med-kalkonbacon"
    , unitLess: [ "Lingonsylt" ]
    }
  , { meal: "Lax med potatis och citronsås"
    , ingredients:
        [ { name: "Fast potatis", amount: 2.0, unit: "st" }
        , { name: "Citron", amount: 0.25, unit: "st" }
        , { name: "Grädde", amount: 0.75, unit: "dl" }
        , { name: "Majsstärkelse", amount: 0.25, unit: "tsk" }
        , { name: "Haricot verts", amount: 40.0, unit: "g" }
        , { name: "Laxfilé", amount: 1.0, unit: "st" }
        , { name: "Smör", amount: 1.0, unit: "msk" }
        ]
    , servings: 0
    , webPage: "https://receptfavoriter.se/recept/ugnspannkaka-med-kalkonbacon"
    , unitLess: [ "Salt", "Peppar" ]
    }
  , { meal: "Vårrullar med nudlar"
    , ingredients:
        [ { name: "Nudlar", amount: 1.0, unit: "paket" }
        , { name: "Minivårrulle", amount: 8.0, unit: "st" }
        ]
    , unitLess: [ "Soja" ]
    , servings: 0
    , webPage: ""
    }
  , { meal: "Korv med bröd"
    , ingredients:
        [ { name: "Kycklingkorv", amount: 3.0, unit: "st" }
        , { name: "Korvbröd", amount: 3.0, unit: "st" }
        ]
    , unitLess: [ "Ketchup", "Senap" ]
    , servings: 0
    , webPage: ""
    }
  , { meal: "Fish and chips"
    , ingredients:
        [ { name: "Torskpanetter", amount: 2.0, unit: "st" }
        , { name: "Pommes", amount: 200.0, unit: "g" }
        ]
    , unitLess: [ "Remouladsås" ]
    , servings: 0
    , webPage: ""
    }
  , { meal: "En veckas frukost o mellanmål"
    , ingredients:
        [ { name: "Gräddost", amount: 1.0, unit: "st" }
        , { name: "Mjölk", amount: 6.0, unit: "l" }
        , { name: "Fil", amount: 3.0, unit: "l" }
        , { name: "Bresmör", amount: 200.0, unit: "g" }
        , { name: "Herrgårdsost", amount: 1.0, unit: "paket" }
        , { name: "Naturell yoghurt", amount: 1.0, unit: "l" }
        , { name: "Mannagryn", amount: 500.0, unit: "g" }
        , { name: "Bröd/limpa", amount: 1.0, unit: "st" }
        , { name: "Granola", amount: 1.0, unit: "paket" }
        ]
    , unitLess: []
    , servings: 0
    , webPage: ""
    }
  , { meal: "En veckas frukt"
    , ingredients:
        [ { name: "Banan", amount: 10.0, unit: "st" }
        , { name: "Apelsin", amount: 5.0, unit: "st" }
        , { name: "Royal gala äpplen", amount: 5.0, unit: "st" }
        , { name: "Frysta bär", amount: 200.0, unit: "g" }
        ]
    , unitLess: []
    , servings: 0
    , webPage: ""
    }
  , { meal: "En Miriam vecka"
    , ingredients:
        [ { name: "Fiskbullar i hummersås", amount: 1.0, unit: "paket" }
        , { name: "Kycklingkorv", amount: 5.0, unit: "st" }
        , { name: "Makaroner", amount: 150.0, unit: "g" }
        , { name: "Majskolvar", amount: 2.0, unit: "st" }
        , { name: "Mozzarella", amount: 150.0, unit: "g" }
        , { name: "Avokado", amount: 1.0, unit: "st" }
        , { name: "Örtbröd för ugn", amount: 1.0, unit: "st" }
        , { name: "Grillad kyckling", amount: 1.0, unit: "påse" }
        , { name: "Spenatstuvning", amount: 100.0, unit: "g" }
        , { name: "Ris med smör", amount: 1.0, unit: "dl" }
        ]
    , unitLess: []
    , servings: 0
    , webPage: ""
    }
  , { meal: "Hamburgare"
    , ingredients:
        [ { name: "Hamburgare 90g", amount: 2.0, unit: "st" }
        , { name: "Rödlök", amount: 0.25, unit: "st" }
        , { name: "Hamburgerbröd", amount: 2.0, unit: "st" }
        , { name: "Tomat", amount: 0.5, unit: "st" }
        ]
    , unitLess: [ "Hamburgerdressing", "Ketchup", "Senap" ]
    , servings: 0
    , webPage: ""
    }
  , { meal: "Tortillapizza"
    , ingredients:
        [ { name: "Tortilla", amount: 2.0, unit: "st" }
        , { name: "Tomatsås", amount: 0.25, unit: "burk" }
        , { name: "Tomat", amount: 0.5, unit: "st" }
        ]
    , unitLess: [ "Ost" ]
    , servings: 0
    , webPage: ""
    }
  , { meal: "Krämig pasta med tonfisk och majs"
    , ingredients:
        [ { name: "Pasta", amount: 100.0, unit: "g" }
        , { name: "Tonfisk i vatten", amount: 0.75, unit: "burk" }
        , { name: "Majs", amount: 0.25, unit: "burk" }
        , { name: "Plommontomat", amount: 0.25, unit: "paket" }
        , { name: "Creme Fraiche", amount: 0.5, unit: "dl" }
        , { name: "Mjölk", amount: 0.025, unit: "l" }
        , { name: "Ketchupchilisås", amount: 1.0, unit: "msk" }
        ]
    , unitLess: [ "Salt", "Peppar" ]
    , servings: 0
    , webPage: "https://www.ica.se/recept/kramig-pasta-med-tonfisk-och-majs-723606/"
    }
  , { meal: "Krämig laxpasta"
    , ingredients:
        [ { name: "Fyll på!", amount: 1.0, unit: "hmm" }
        ]
    , unitLess: [ "Salt", "Peppar" ]
    , servings: 0
    , webPage: "https://zeinaskitchen.se/kramig-laxpasta/"
    }
  ]
--
