module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Number (cos, sin)

type Germ = {
    pos :: Position,
    dir :: Number,
    name :: String,
    age :: Int
}

type Position = {
    x :: Number,
    y :: Number
}

type Bacteria = {
    pos :: Position,
    dir :: Number,
    age :: Int
}

foreign import simulate ::
 Array Germ ->
 (Array Germ -> Array Germ) ->
 Effect Unit

main :: Effect Unit
main = do
  simulate [{ pos: {x: 50.0, y: 50.0}, dir: 0.15, name: "Samuel", age: 25}] tick

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



