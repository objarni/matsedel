module Main where

import Prelude

import Effect (Effect)
import PureGerm (runGerms)
import Data.Map (Map)
import Data.Map (fromFoldable) as Map
import Data.Tuple
import Data.Array

main :: Effect Unit
main = do
  run initialMeals2 initialMeals meals2ingredients addServingOfMeal removeServingOfMeal
  runGerms

-- Old types
type Meals = Array Meal
type Meal =
  { meal :: String
  , ingredients :: Ingredients
  , servings :: Int
  }

type Ingredient = { name :: String, amount :: Number, unit :: String }
type Ingredients = Array Ingredient

-- New types
type Ingredient2 = { amount :: Number, unit :: String }
type Ingredients2 = Map String Ingredient2
type Meal2 = { ingredients :: Ingredients2, servings :: Int }
type Meals2 = Map String Meal2

upgradeIngredient :: Ingredient -> Tuple String Ingredient2
upgradeIngredient ingredient = Tuple ingredient.name { amount: ingredient.amount, unit: ingredient.unit }

upgradeIngredients :: Ingredients -> Ingredients2
upgradeIngredients ingredients = Map.fromFoldable (upgradeIngredient <$> ingredients)

upgradeMeal :: Meal -> Tuple String Meal2
upgradeMeal meal = Tuple meal.meal { ingredients: upgradeIngredients meal.ingredients, servings: meal.servings }

upgradeMeals :: Meals -> Meals2
upgradeMeals meals = Map.fromFoldable (upgradeMeal <$> meals)

initialMeals2 :: Meals2
initialMeals2 = upgradeMeals initialMeals

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
    }
  ]

meals2ingredients :: IngredientsFromMealsFn
meals2ingredients meals = meals >>= \meal -> meal.ingredients

addServingOfMeal :: IncFn
addServingOfMeal _ meals = meals

removeServingOfMeal :: DecFn
removeServingOfMeal _ meals = meals

type IncFn = String -> Meals -> Meals
type DecFn = String -> Meals -> Meals
type IngredientsFromMealsFn = Meals -> Ingredients

foreign import run :: Meals2 -> Meals -> IngredientsFromMealsFn -> IncFn -> DecFn -> Effect Unit
