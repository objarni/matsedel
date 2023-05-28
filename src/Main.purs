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
  , age :: Int
  , maxAge :: Int
  }

tick :: Model -> Model
tick m = m
  { germs = concatMap _.germs result
  , foods = concatMap _.foods result
  }
  where
  result = map tickGerm m.germs

tickGerm :: Germ -> Model
tickGerm germ = { germs: [ g ], foods: [] }
  where
  g = germ
    { pos = germ.pos
        { x = germ.pos.x + dx
        , y = germ.pos.y + dy
        }
    , age = germ.age + 1
    }
  dx = cos germ.dir
  dy = sin germ.dir

main :: Effect Unit
main = do
  let germs = [ { pos: { x: 50.0, y: 50.0 }, dir: 0.15, age: 25, maxAge: 50 } ] :: Array Germ
  simulate { germs: germs, foods: [ { x: 1.0, y: 1.0 } ] } tick

foreign import simulate :: Model -> (Model -> Model) -> Effect Unit

