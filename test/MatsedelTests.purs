module MatsedelTests where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Main (Ingredient, Meal)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.TeamCity (teamcityReporter)
import Test.Spec.Runner (runSpec)
import Data.Int (toNumber) as Data.Int
import Data.Map (fromFoldable)
import Data.Tuple (Tuple(Tuple))
import Data.Map.Internal (Map, toUnfoldable, values)
import Data.List as List
import Data.Map as Map

toNumber :: Int -> Number
toNumber = Data.Int.toNumber

flattenMeal :: Meal -> Array Ingredient
flattenMeal meal =
  let
    servings = meal.servings
    ingredients = meal.ingredients
  in
    ingredients
      # map \ingredient ->
          { name: ingredient.name
          , amount: ingredient.amount * (toNumber servings)
          , unit: ingredient.unit
          }

list = List.fromFoldable

main :: Effect Unit
main = launchAff_ $ runSpec [ teamcityReporter ] do

  describe "PureScript Map data structure" do
    it "can access values via values function" do
      let
        aMap :: Map Int String
        aMap = Map.fromFoldable [Tuple 1 "one", Tuple 2 "two"]
      values aMap # shouldEqual (list ["one",  "two"])
    it "can access keys and values via toUnfoldable" do
      let
        aMap = fromFoldable [Tuple 1 "one", Tuple 2 "two"]
        pairs = toUnfoldable aMap
        allkeys = map (\(Tuple k _) -> k) pairs
        allvalues = map (\(Tuple _ v) -> v) pairs
      allkeys # shouldEqual [ 1, 2 ]
      allvalues # shouldEqual [ "one", "two" ]
    it "can access keys and values via toUnfoldable" do
      let
        aMap = fromFoldable [Tuple 1 "one", Tuple 2 "two"]
        pairs = toUnfoldable aMap
        allkeys = map (\(Tuple k _) -> k) pairs
        allvalues = map (\(Tuple _ v) -> v) pairs
      allkeys # shouldEqual [ 1, 2 ]
      allvalues # shouldEqual [ "one", "two" ]

  describe "flattenMeal" do
    it "uses servings to compute ingredients" do
      let
        flattened = flattenMeal
          { meal: "Stekt lax med rotfrukter i ugn"
          , ingredients:
              [ { name: "Laxfilé", amount: 1.0, unit: "st" }
              , { name: "Fast potatis", amount: 1.0, unit: "st" }
              , { name: "Morot", amount: 1.0, unit: "st" }
              , { name: "Sötpotatis", amount: 1.0, unit: "st" }
              , { name: "Rödlök", amount: 0.5, unit: "st" }
              , { name: "Vitlök", amount: 2.25, unit: "st" }
              , { name: "Olivolja", amount: 0.5, unit: "msk" }
              , { name: "Smör", amount: 1.0, unit: "msk" }
              , { name: "Citronpeppar", amount: 0.0, unit: "-" }
              , { name: "Yoghurt", amount: 0.4, unit: "dl" }
              , { name: "Fetaost", amount: 40.0, unit: "g" }
              , { name: "Örter", amount: 0.25, unit: "dl" }
              ]
          , servings: 2
          }
      flattened # shouldEqual
        [ { name: "Laxfilé", amount: 2.0, unit: "st" }
        , { name: "Fast potatis", amount: 2.0, unit: "st" }
        , { name: "Morot", amount: 2.0, unit: "st" }
        , { name: "Sötpotatis", amount: 2.0, unit: "st" }
        , { name: "Rödlök", amount: 1.0, unit: "st" }
        , { name: "Vitlök", amount: 4.5, unit: "st" }
        , { name: "Olivolja", amount: 1.0, unit: "msk" }
        , { name: "Smör", amount: 2.0, unit: "msk" }
        , { name: "Citronpeppar", amount: 0.0, unit: "-" }
        , { name: "Yoghurt", amount: 0.8, unit: "dl" }
        , { name: "Fetaost", amount: 80.0, unit: "g" }
        , { name: "Örter", amount: 0.5, unit: "dl" }
        ]
--    describe "summedIngredients" do
--      it "sums same ingredients" do
--        let
--          summed = summedIngredients
--            [ { name: "Laxfilé", amount: 1.0, unit: "st" } ]
--            [ { name: "Laxfilé", amount: 3.0, unit: "st" } ]
--        summed # shouldEqual [ { name: "Laxfilé", amount: 4.0, unit: "st" } ]
--      it "combines different ingredients" do
--        let
--          summed = summedIngredients
--            [ { name: "Laxfilé", amount: 1.0, unit: "st" } ]
--            [ { name: "Punchpralin", amount: 3.0, unit: "st" } ]
--        summed # shouldEqual
--          [ { name: "Laxfilé", amount: 1.0, unit: "st" }
--          , { name: "Punchpralin", amount: 3.0, unit: "st" }
--          ]
