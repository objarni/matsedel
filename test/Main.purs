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



main :: Effect Unit
main = launchAff_ $ runSpec [teamcityReporter] $
    describe "Germ behaviour" do
        it "can convert numbers to strings" do
            toStringWith (fixed 1) 0.12 # shouldEqual "0.1"
        it "should be able to move horisontally" do
            tick {
                germs : [{pos: { x:0.0, y:0.0}, dir: 0.0, age: 0}],
                foods: []
            } # shouldEqual {
                germs : [{pos: { x:1.0, y:0.0}, dir: 0.0, age: 1}],
                foods: []
                }
        it "should be able to move verticalliy" do
            let nextState = tick {
                germs : [{pos: { x:0.0, y:0.0}, dir: 3.1415/2.0, age: 0}],
                foods: []
            }
            nextState.germs <#> _.pos.y <#> toStringWith (fixed 1) # shouldEqual ["1.0"]
-- moving germß
-- - ordinary move
-- - eating food
-- - onto wall
-- - splitting in two
-- - die of age
-- - die of hunger
