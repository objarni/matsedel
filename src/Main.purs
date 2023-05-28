module Main where

import Prelude
import Effect (Effect)
import Data.Number (cos, sin)
import Data.Array (concatMap)

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
  g = germ
    { pos = germ.pos
        { x = germ.pos.x + dx
        , y = germ.pos.y + dy
        }
    , lifeLeft = germ.lifeLeft - 1
    }
  dx = cos germ.dir
  dy = sin germ.dir

main :: Effect Unit
main = do
  let germs = [ { pos: { x: 50.0, y: 50.0 }, dir: 0.15, lifeLeft: 25 } ] :: Array Germ
  simulate { germs: germs, foods: [ { x: 1.0, y: 1.0 } ] } tick

foreign import simulate :: Model -> (Model -> Model) -> Effect Unit

