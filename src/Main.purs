module Main where

import Prelude

import Effect (Effect)
import PureGerm (runGerms)

main :: Effect Unit
main = do
  run initialMeals meals2ingredients addServingOfMeal removeServingOfMeal
  runGerms

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
addServingOfMeal mealName meals = meals

removeServingOfMeal :: DecFn
removeServingOfMeal mealName meals = meals

type Meals = Array Meal

type Meal =
  { meal :: String
  , ingredients :: Ingredients
  , servings :: Int
  }

type Ingredient = { name :: String, amount :: Number, unit :: String }

type Ingredients = Array Ingredient
type IncFn = String -> Meals -> Meals
type DecFn = String -> Meals -> Meals
type IngredientsFromMealsFn = Meals -> Ingredients

foreign import run :: Meals -> IngredientsFromMealsFn -> IncFn -> DecFn -> Effect Unit
