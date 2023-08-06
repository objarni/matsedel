module Main where

import Prelude
import Effect (Effect)
import Data.Number (cos, pi, sin)
import Data.Array (concatMap, replicate)
import Effect.Random (randomRange)
import Data.Traversable (sequence)
import Data.Int (floor)

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

main :: Effect Unit
main = do
  --  let germs = [ { pos: { x: 50.0, y: 50.0 }, dir: 0.15, lifeLeft: 25 } ] :: Array Germ
  setIngredients [ { name: "sugar", amount: 1.0, unit: "cup" } ]
  foods <- sequence $ replicate 100 random_food
  germs <- sequence $ replicate 100 random_germ
  simulate { germs: germs, foods: foods } tick

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
  hitWall = wantedPos.x < 0.0 || wantedPos.x > 500.0 || wantedPos.y < 0.0 || wantedPos.y > 500.0
  newPos = if hitWall then germ.pos else wantedPos
  newDir = if hitWall then germ.dir + 3.14 / 2.0 else germ.dir

random_food :: Effect { x :: Number, y :: Number }
random_food = random_pos

random_pos :: Effect { x :: Number, y :: Number }
random_pos = do
  x <- randomRange 0.0 500.0
  y <- randomRange 0.0 500.0
  pure { x, y }

random_germ :: Effect Germ
random_germ = do
  pos <- random_pos
  dir <- randomRange 0.0 (2.0 * pi)
  ll <- randomRange 100.0 500.0
  pure { pos, dir, lifeLeft: floor ll }

foreign import simulate :: Model -> (Model -> Model) -> Effect Unit

type Ingredient = { name :: String, amount :: Number, unit :: String }

type Ingredients = Array Ingredient

foreign import setIngredients :: Ingredients -> Effect Unit
