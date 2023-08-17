module Main where

import Data.Array
import Data.Tuple
import Prelude

import Data.Map (Map)
import Debug (spy)
import Effect (Effect)
import PureGerm (runGerms)
import Data.Int (toNumber) as Data.Int
import Data.Map (empty, fromFoldable) as Map
import Data.Map.Internal (unionWith) as Map

main :: Effect Unit
main = do
  run (spy "initialMeals" initialMeals) meals2ingredients addServingOfMeal removeServingOfMeal
  runGerms

-- Old types
type Meals = Array Meal
type Meal =
  { meal :: String
  , ingredients :: Ingredients
  , servings :: Int
  , webPage :: String
  }

type Ingredient = { name :: String, amount :: Number, unit :: String }
type Ingredients = Array Ingredient

-- New types
type Ingredient2 = { amount :: Number, unit :: String }
type Ingredients2 = Map String Ingredient2
type Meal2 = { ingredients :: Ingredients2, servings :: Int, webPage :: String }
type Meals2 = Map String Meal2

upgradeIngredient :: Ingredient -> Tuple String Ingredient2
upgradeIngredient ingredient = Tuple ingredient.name { amount: ingredient.amount, unit: ingredient.unit }

upgradeIngredients :: Ingredients -> Ingredients2
upgradeIngredients ingredients = Map.fromFoldable (upgradeIngredient <$> ingredients)

upgradeMeal :: Meal -> Tuple String Meal2
upgradeMeal meal = Tuple meal.meal
  { ingredients: upgradeIngredients meal.ingredients
  , servings: meal.servings
  , webPage: meal.webPage
  }

upgradeMeals :: Meals -> Meals2
upgradeMeals meals = Map.fromFoldable (upgradeMeal <$> meals)

initialMeals :: Meals
initialMeals =
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
        , { name: "Citronpeppar", amount: 0.0, unit: "-" }
        , { name: "Yoghurt", amount: 0.4, unit: "dl" }
        , { name: "Fetaost", amount: 40.0, unit: "g" }
        , { name: "Örter", amount: 0.25, unit: "dl" }
        ]
    , servings: 2
    , webPage: "https://www.mathem.se/recept/lax-i-ugn-med-rotfrukter-och-fetaost"
    }
  ]

meals2ingredients :: IngredientsFromMealsFn
meals2ingredients _ = []

allIngredients :: Meals -> Array Ingredients
allIngredients meals = meals <#> (\m -> flattenMeal m)

flattenMeal :: Meal -> Array Ingredient
flattenMeal meal =
  let
    servings = meal.servings
    ingredients = meal.ingredients
  in
    ingredients
      # map \ingredient ->
          { name: ingredient.name
          , amount: ingredient.amount * (Data.Int.toNumber servings)
          , unit: ingredient.unit
          }

mealsToIngredientMaps :: Meals -> Array (Map String Ingredient2)
mealsToIngredientMaps meals = upgradeIngredients <$> allIngredients meals

sumIngredients :: Ingredient2 -> Ingredient2 -> Ingredient2
sumIngredients ingredient1 ingredient2 = ingredient1 { amount = ingredient1.amount + ingredient2.amount }

mergeIngredientsMaps :: Array (Map String Ingredient2) -> Map String Ingredient2
mergeIngredientsMaps = foldl (Map.unionWith sumIngredients) Map.empty

tupleToIngredient :: Tuple String Ingredient2 -> Ingredient
tupleToIngredient t = { name, amount, unit }
  where
  name = fst t
  amount = (snd t).amount
  unit = (snd t).unit

addServingOfMeal :: IncFn
addServingOfMeal _ meals = incMeal <$> meals
  where
  incMeal meal = meal { servings = meal.servings + 1 }

removeServingOfMeal :: DecFn
removeServingOfMeal _ meals = decMeal <$> meals
  where
  decMeal meal = meal { servings = meal.servings - 1 }

type IncFn = String -> Meals -> Meals
type DecFn = String -> Meals -> Meals
type IngredientsFromMealsFn = Meals -> Ingredients

foreign import run :: Meals -> IngredientsFromMealsFn -> IncFn -> DecFn -> Effect Unit
