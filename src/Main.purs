module Main where

import Prelude

import Effect (Effect)
import PureGerm (runGerms)

main :: Effect Unit
main = do
  run initialMeals addMeal removeMeal
  runGerms

initialMeals :: Meals
initialMeals =
  [ { meal: "Pasta"
    , ingredients:
        [ { name: "Pasta", amount: 100.0, unit: "g" }
        , { name: "Tomato", amount: 1.0, unit: "pcs" }
        ]
    , servings: 2
    }
  ]

addMeal :: IncFn
addMeal name meals = meals

removeMeal :: DecFn
removeMeal name meals = meals

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

foreign import run :: Meals -> IncFn -> DecFn -> Effect Unit
