module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Main (tick)
import Test.Spec (describe, it, pending')
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.TeamCity (teamcityReporter)
import Test.Spec.Runner (runSpec)
import Data.Number.Format (fixed, toStringWith)
import Data.Array (length)

main :: Effect Unit
main = launchAff_ $ runSpec [ teamcityReporter ] do
  describe "PureScript " do
    it "can convert numbers to strings" do
      toStringWith (fixed 1) 0.12 # shouldEqual "0.1"
  describe "Germs" do
    it "can move horisontally" do
      tick
        { germs: [ { pos: { x: 0.0, y: 0.0 }, dir: 0.0, age: 0, maxAge: 10 } ]
        , foods: []
        } # shouldEqual
        { germs: [ { pos: { x: 1.0, y: 0.0 }, dir: 0.0, age: 1, maxAge: 10 } ]
        , foods: []
        }
    it "can move vertically" do
      let
        nextState = tick
          { germs: [ { pos: { x: 0.0, y: 0.0 }, dir: 3.1415 / 2.0, age: 0, maxAge: 10 } ]
          , foods: []
          }
      nextState.germs <#> _.pos.y <#> toStringWith (fixed 1) # shouldEqual [ "1.0" ]
    pending' "produce food when dying of age" do
      let
        nextState = tick
          { germs: [ { pos: { x: 0.0, y: 0.0 }, dir: 3.1415 / 2.0, age: 50, maxAge: 50 } ]
          , foods: []
          }
      [ length nextState.germs, length nextState.foods ] # shouldEqual [ 0, 1 ]
-- moving germß
-- - ordinary move
-- - eating food
-- - onto wall
-- - splitting in two
-- - die of age
-- - die of hunger
