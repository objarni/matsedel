module MealTypes where

type Meals = Array Meal
type Meal =
  { meal :: String
  , ingredients :: Ingredients
  , servings :: Int
  , webPage :: String
  }

type Ingredient = { name :: String, amount :: Number, unit :: String }
type Ingredients = Array Ingredient

