module MatsedelTests where

import Data.List (List)
import Data.Map
import Data.Tuple (Tuple(..))
import Prelude (class Monad, discard, Unit, map, (#), ($), (+))

import Control.Monad.Error.Class (class MonadThrow)
import Data.Foldable (class Foldable)
import Data.Map.Internal (Map, values)
import Data.Unfoldable (class Unfoldable)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Exception (Error)
import Main (findInconsistencies, flattenMeal, mealsToIngredients, mealsToUnitLess, upgradeMeals)
import Test.Spec (SpecT, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.TeamCity (teamcityReporter)
import Test.Spec.Runner (runSpec)
import Data.List as List
import Data.Map (unionWith) as Map
import MealTypes (Meals)
import Data.Maybe (Maybe(..))
import Data.Map.Internal (fromFoldable, toUnfoldable) as Map

list :: forall f. Foldable f => (forall a. f a -> List a)
list = List.fromFoldable

type TestSuite = forall a b. Monad a => MonadThrow Error b => SpecT b Unit a Unit

mapTests :: TestSuite
mapTests = describe "PureScript Map data structure" do
  it "can access values via values function" do
    let
      aMap :: Map Int String
      aMap = Map.fromFoldable [ Tuple 1 "one", Tuple 2 "two" ]
    values aMap # shouldEqual (list [ "one", "two" ])
  it "can access keys and values via toUnfoldable" do
    let
      aMap = Map.fromFoldable [ Tuple 1 "one", Tuple 2 "two" ]
      pairs = Map.toUnfoldable aMap
      allkeys = map (\(Tuple k _) -> k) pairs
      allvalues = map (\(Tuple _ v) -> v) pairs
    allkeys # shouldEqual [ 1, 2 ]
    allvalues # shouldEqual [ "one", "two" ]
  it "can be merged with another map given a merge function" do
    let
      aMap = Map.fromFoldable [ Tuple "morot" 2, Tuple "broccoli" 1 ]
      bMap = Map.fromFoldable [ Tuple "broccoli" 5, Tuple "pilsner" 3 ]
      combinedMap = Map.unionWith (+) aMap bMap
      combinedAsList = Map.toUnfoldable combinedMap
    combinedAsList # shouldEqual [ Tuple "broccoli" 6, Tuple "morot" 2, Tuple "pilsner" 3 ]

upgradeMealsTests :: TestSuite
upgradeMealsTests = describe "upgradeMeals" do
  it "upgrades example meals" do
    let
      exampleMeals =
        [ { meal: "Stekt lax med rotfrukter i ugn"
          , ingredients:
              [ { name: "Laxfilé", amount: 1.0, unit: "st" }
              , { name: "Fast potatis", amount: 1.0, unit: "st" }
              , { name: "Morot", amount: 1.0, unit: "st" }
              , { name: "Sötpotatis", amount: 1.0, unit: "st" }
              , { name: "Rödlök", amount: 0.5, unit: "st" }
              , { name: "Vitlök", amount: 2.25, unit: "st" }
              , { name: "Olivolja", amount: 0.5, unit: "msk" }
              , { name: "Smör", amount: 1.0, unit: "msk" }
              , { name: "Yoghurt", amount: 0.4, unit: "dl" }
              , { name: "Fetaost", amount: 40.0, unit: "g" }
              , { name: "Örter", amount: 0.25, unit: "dl" }
              ]
          , servings: 2
          , webPage: "https://www.mathem.se/recept/lax-i-ugn-med-rotfrukter-och-fetaost"
          , unitLess: []
          }
        , { meal: "Äggröra med fetaost och pasta"
          , ingredients:
              [ { name: "Grädde", amount: 0.25, unit: "dl" }
              , { name: "Ägg", amount: 2.0, unit: "st" }
              , { name: "Fetaost", amount: 25.0, unit: "g" }
              , { name: "Pasta", amount: 100.0, unit: "g" }
              ]
          , servings: 0
          , webPage: "https://www.elinaomickesmat.se/kramig-aggrora-med-fetaost/"
          , unitLess: []
          }
        ]
    Map.toUnfoldable (upgradeMeals exampleMeals) # shouldEqual
      [ Tuple "Stekt lax med rotfrukter i ugn"
          { ingredients:
              fromFoldable
                [ Tuple "Fast potatis" { amount: 1.0, unit: "st" }
                , Tuple "Fetaost" { amount: 40.0, unit: "g" }
                , Tuple "Laxfilé" { amount: 1.0, unit: "st" }
                , Tuple "Morot" { amount: 1.0, unit: "st" }
                , Tuple "Olivolja" { amount: 0.5, unit: "msk" }
                , Tuple "Rödlök" { amount: 0.5, unit: "st" }
                , Tuple "Smör" { amount: 1.0, unit: "msk" }
                , Tuple "Sötpotatis" { amount: 1.0, unit: "st" }
                , Tuple "Vitlök" { amount: 2.25, unit: "st" }
                , Tuple "Yoghurt" { amount: 0.4, unit: "dl" }
                , Tuple "Örter" { amount: 0.25, unit: "dl" }
                ]
          , servings: 2
          , webPage: "https://www.mathem.se/recept/lax-i-ugn-med-rotfrukter-och-fetaost"
          }
      , Tuple "Äggröra med fetaost och pasta"
          { ingredients:
              fromFoldable
                [ Tuple "Fetaost" { amount: 25.0, unit: "g" }
                , Tuple "Grädde" { amount: 0.25, unit: "dl" }
                , Tuple "Pasta" { amount: 100.0, unit: "g" }
                , Tuple "Ägg" { amount: 2.0, unit: "st" }
                ]
          , servings: 0
          , webPage: "https://www.elinaomickesmat.se/kramig-aggrora-med-fetaost/"
          }
      ]

flattenTests :: TestSuite
flattenTests = describe "flattenMeal" do
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
        , webPage: ""
        , unitLess: []
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

meals2ingredientsTests :: TestSuite
meals2ingredientsTests = describe "meals2ingredients" do
  it "sums ingredients of several served meals" do
    let
      twoMeals :: Meals
      twoMeals =
        [ { meal: "Stekt lax med rotfrukter i ugn"
          , ingredients:
              [ { name: "Laxfilé", amount: 5.0, unit: "st" }, { name: "Morot", amount: 3.0, unit: "st" } ]
          , servings: 10
          , webPage: ""
          , unitLess: []
          }
        , { meal: "Stekt lax med ris"
          , ingredients:
              [ { name: "Laxfilé", amount: 3.0, unit: "st" } ]
          , servings: 2
          , webPage: ""
          , unitLess: []
          }
        , { meal: "Stekt lax med potatis"
          , ingredients:
              [ { name: "Potatis", amount: 5.0, unit: "st" } ]
          , servings: 0
          , webPage: ""
          , unitLess: []
          }
        ]

      ingredientsArray = mealsToIngredients twoMeals

    ingredientsArray # shouldEqual
      [ { amount: 56.0, name: "Laxfilé", unit: "st" }
      , { amount: 30.0, name: "Morot", unit: "st" }
      ]

meals2unitLessTests :: TestSuite
meals2unitLessTests = describe "meals2unitLess" do
  it "sums unitless ingredients of several served meals" do
    let
      twoMeals :: Meals
      twoMeals =
        [ { meal: "Stekt lax med rotfrukter i ugn"
          , ingredients:
              [ { name: "Laxfilé", amount: 5.0, unit: "st" }, { name: "Morot", amount: 3.0, unit: "st" } ]
          , servings: 10
          , webPage: ""
          , unitLess: [ "Citronpeppar", "Salt" ]
          }
        , { meal: "Stekt lax med ris"
          , ingredients:
              [ { name: "Laxfilé", amount: 3.0, unit: "st" } ]
          , servings: 2
          , webPage: ""
          , unitLess: [ "Salt", "Peppar" ]
          }
        ]

      unitLessArray = mealsToUnitLess twoMeals

    unitLessArray # shouldEqual [ "Citronpeppar", "Salt", "Peppar" ]

validateMealsTests :: TestSuite
validateMealsTests = describe "meals2unitLess" do
  it "gives an error if the same ingredient is measured in different units" do
    let
      twoMeals :: Meals
      twoMeals =
        [ { meal: "Stekt lax med rotfrukter i ugn"
          , ingredients:
              [ { name: "Laxfilé", amount: 5.0, unit: "st" } ]
          , servings: 10
          , webPage: ""
          , unitLess: [ "Citronpeppar", "Salt" ]
          }
        , { meal: "Stekt lax med ris"
          , ingredients:
              [ { name: "Laxfilé", amount: 150.0, unit: "g" }
              , { name: "Socker", amount: 100.0, unit: "ml" }
              ]
          , servings: 2
          , webPage: ""
          , unitLess: [ "Salt", "Peppar" ]
          }
        ]

      errorMessage = findInconsistencies twoMeals

    errorMessage # shouldEqual (Just "Hittade ingrediensen Laxfilé med flera enheter: g st")

main :: Effect Unit
main = launchAff_ $ runSpec [ teamcityReporter ] do

  mapTests

  upgradeMealsTests

  flattenTests

  meals2ingredientsTests

  meals2unitLessTests

  validateMealsTests
