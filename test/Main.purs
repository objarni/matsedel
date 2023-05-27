module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Runner (runSpec)
import Test.Spec.Reporter.TeamCity (teamcityReporter)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Main (tick)

main :: Effect Unit
main = launchAff_ $ runSpec [teamcityReporter] $
    describe "Germ behaviour" do
        it "should be able to move" do
            tick {
                germs : [{pos: { x:0.0, y:0.0}, dir: 0.0, age: 0}],
                foods: []
            } # shouldEqual {
                germs : [{pos: { x:1.0, y:0.0}, dir: 0.0, age: 1}],
                foods: []
                }
-- moving germ
-- - ordinary move
-- - eating food
-- - onto wall
-- - splitting in two
-- - die of age
-- - die of hunger
