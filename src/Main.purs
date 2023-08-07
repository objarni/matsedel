module Main where

import Prelude
import Effect (Effect)
import Data.Number (cos, pi, sin)
import Data.Array (concatMap, replicate)
import Effect.Random (randomRange)
import Data.Traversable (sequence)
import Data.Int (floor)

main :: Effect Unit
main = do
  setMeals
    [ { meal: "Stekt lax med rotfrukter"
      , servings: 0
      , ingredients: [ { name: "Lax", amount: 1.0, unit: "kg" }, { name: "Rotfrukter", amount: 1.0, unit: "kg" } ]
      }
    , { meal: "Äggröra med fetaost och pasta"
      , servings: 0
      , ingredients: [ { name: "Lax", amount: 1.0, unit: "kg" }, { name: "Rotfrukter", amount: 1.0, unit: "kg" } ]
      }
    ]
  setIngredients
    [ { name: "Tortillabröd", amount: 2.0, unit: "paket" }
    , { name: "Salsa", amount: 2.0, unit: "dl" }
    , { name: "Fast potatis", amount: 4.0, unit: "st" }
    ]
  foods <- sequence $ replicate 100 random_food
  germs <- sequence $ replicate 100 random_germ
  simulate { germs: germs, foods: foods } tick

worldSize :: Number
worldSize = 300.0

type Meals = Array Meal

type Meal =
  { meal :: String
  , ingredients :: Ingredients
  , servings :: Int
  }

type Ingredient = { name :: String, amount :: Number, unit :: String }

type Ingredients = Array Ingredient

foreign import setMeals :: Meals -> Effect Unit
foreign import setIngredients :: Ingredients -> Effect Unit

-- Below: puregerm code

type Model =
  { germs :: Array Germ
  , foods :: Array Food
  }

type Position =
  { x :: Number
  , y :: Number
  }

type Food = Position

type Germ =
  { pos :: Position
  , dir :: Number
  , lifeLeft :: Int
  }

tick :: Model -> Model
tick m = m
  { germs = concatMap _.germs result
  , foods = concatMap _.foods result <> m.foods
  }
  where
  result = map tickGerm m.germs

tickGerm :: Germ -> Model
tickGerm germ = if germ.lifeLeft == 0 then { germs: [], foods: [ g.pos ] } else { germs: [ g ], foods: [] }
  where
  g = { pos: newPos, lifeLeft: germ.lifeLeft - 1, dir: newDir }
  wantedPos = germ.pos
    { x = germ.pos.x + (cos germ.dir)
    , y = germ.pos.y - (sin germ.dir)
    }
  hitWall = wantedPos.x < 0.0 || wantedPos.x > worldSize || wantedPos.y < 0.0 || wantedPos.y > worldSize
  newPos = if hitWall then germ.pos else wantedPos
  newDir = if hitWall then germ.dir + 3.14 / 2.0 else germ.dir

random_food :: Effect { x :: Number, y :: Number }
random_food = random_pos

random_pos :: Effect { x :: Number, y :: Number }
random_pos = do
  x <- randomRange 0.0 worldSize
  y <- randomRange 0.0 worldSize
  pure { x, y }

random_germ :: Effect Germ
random_germ = do
  pos <- random_pos
  dir <- randomRange 0.0 (2.0 * pi)
  ll <- randomRange 100.0 worldSize
  pure { pos, dir, lifeLeft: floor ll }

foreign import simulate :: Model -> (Model -> Model) -> Effect Unit
