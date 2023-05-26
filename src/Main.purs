module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

type Germ = {
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
  log "🍝Hej"
  simulate [{ name: "Samuel", age: 25}] tick

tick :: Array Germ -> Array Germ
tick = map (\germ -> germ { age = germ.age + 1 })



