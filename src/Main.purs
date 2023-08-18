module Main where

import Data.Array (foldl)
import Data.Tuple (Tuple(..), fst, snd)
import Prelude

import Data.Map (Map)
import Debug (spy)
import Effect (Effect)
import PureGerm (runGerms)
import Data.Int (toNumber) as Data.Int
import Data.Map (empty, fromFoldable) as Map
import Data.Map.Internal (toUnfoldable, unionWith) as Map
import Data.Unfoldable (class Unfoldable)
import MealTypes (Ingredient, Ingredients, Meal, Meals)
import Meals (standardMatsedel)

main :: Effect Unit
main = do
  run (spy "initialMeals" standardMatsedel) meals2ingredients addServingOfMeal removeServingOfMeal
  runGerms

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

mealsToIngredients :: Meals -> Ingredients
mealsToIngredients meals =
  let

    mealsToIngredientMaps :: Meals -> Array (Map String Ingredient2)
    mealsToIngredientMaps = \m -> upgradeIngredients <$> allIngredients m

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

    listOfTuples :: forall a. Unfoldable a => a (Tuple String { amount :: Number, unit :: String })
    listOfTuples = Map.toUnfoldable
      $ mergeIngredientsMaps
      $ mealsToIngredientMaps meals

    listOfIngredients :: forall a. Functor a => Unfoldable a => a { amount :: Number, name :: String, unit :: String }
    listOfIngredients = tupleToIngredient <$> listOfTuples
  in
    listOfIngredients

meals2ingredients :: IngredientsFromMealsFn
meals2ingredients = mealsToIngredients

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

addServingOfMeal :: IncFn
addServingOfMeal meal meals = incMeal <$> meals
  where
  incMeal aMeal =
    if aMeal.meal == meal then aMeal { servings = aMeal.servings + 1 }
    else aMeal

removeServingOfMeal :: DecFn
removeServingOfMeal meal meals = decMeal <$> meals
  where
  decMeal aMeal =
    if aMeal.meal == meal then aMeal { servings = aMeal.servings - 1 }
    else aMeal

type IncFn = String -> Meals -> Meals
type DecFn = String -> Meals -> Meals
type IngredientsFromMealsFn = Meals -> Ingredients

foreign import run :: Meals -> IngredientsFromMealsFn -> IncFn -> DecFn -> Effect Unit
