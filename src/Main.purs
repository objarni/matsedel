module Main where

import Prelude
import Effect (Effect)
import Data.Number (cos, sin)

type Germ = {
    pos :: Position,
    dir :: Number,
    age :: Int
}

type Position = {
    x :: Number,
    y :: Number
}


main :: Effect Unit
main = do
  simulate [{ pos: {x: 50.0, y: 50.0}, dir: 0.15, age: 25}] tick

tick :: Array Germ -> Array Germ
tick = map tickGerm

tickGerm :: Germ -> Germ
tickGerm germ = germ
 { pos = germ.pos
     { x = germ.pos.x + dx
     , y = germ.pos.y + dy
     }
 }
 where
    dx :: Number
    dx = cos germ.dir
    dy = sin germ.dir



foreign import simulate ::
 Array Germ ->
 (Array Germ -> Array Germ) ->
 Effect Unit

