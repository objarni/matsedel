module Main where

import Data.Array (concat, concatMap, filter, foldl, head, length, nub)
import Data.Tuple (Tuple(..), fst, snd)
import Prelude

import Data.Map (Map)
import Debug (spy)
import Effect (Effect)
import PureGerm (runGerms)
import Data.Int (toNumber) as Data.Int
import Data.Map (empty, fromFoldable) as Map
import Data.Map.Internal (fromFoldableWith, toUnfoldable, unionWith) as Map
import Data.Unfoldable (class Unfoldable)
import MealTypes (Ingredient, Ingredients, Meal, Meals)
import Meals (standardMatsedel)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Semigroup ((<>))
import Data.Ord ((>))
import Data.Functor ((<#>), (<$>))

main :: Effect Unit
main = do
  error "Error message seems to work now"
  run (spy "initialMeals" standardMatsedel) meals2ingredients meals2unitLess addServingOfMeal removeServingOfMeal
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

    nonZeroIngredients = filter (\ingredient -> ingredient.amount > 0.0) listOfIngredients

  in
    nonZeroIngredients

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

type IncFn = String -> Meals -> Meals
type DecFn = String -> Meals -> Meals

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

mealsToUnitLess :: Meals -> Array String
mealsToUnitLess meals = filter (\meal -> meal.servings > 0) meals
  # concatMap (\meal -> meal.unitLess)
  # nub

meals2unitLess = mealsToUnitLess

type IngredientsFromMealsFn = Meals -> Ingredients
type UnitLessFromMealsFn = Meals -> Array String

foreign import run :: Meals -> IngredientsFromMealsFn -> UnitLessFromMealsFn -> IncFn -> DecFn -> Effect Unit
foreign import error :: String -> Effect Unit

ingredientUnitsArray :: Meals -> Array (Tuple String (Array String))
ingredientUnitsArray meals = Map.toUnfoldable $ ingredientUnitsMap meals

findInconsistencies :: Meals -> Maybe String
findInconsistencies meals = case head (ingredientsWithMultipleUnitsArray meals) of
  Just (Tuple ingredient units) ->
      Just ("Hittade ingrediensen " <> ingredient <> " med flera enheter:" <> unitsText)
        where unitsText = foldl (\acc unit -> acc <> " " <> unit) "" units
  Nothing -> Nothing

ingredientsWithMultipleUnitsArray :: Meals -> Array (Tuple String (Array String))
ingredientsWithMultipleUnitsArray meals = filter (\(Tuple _ units) -> length units > 1) (ingredientUnitsArray meals)

ingredientUnitsMap :: Meals -> Map String (Array String)
ingredientUnitsMap meals = Map.fromFoldableWith (\array1 array2 -> array1 <> array2) allIngredientsUnits
  where
  allIngredientsUnits :: Array (Tuple String (Array String))
  allIngredientsUnits = (allIngredientUnitTuples meals) <#> (\(Tuple ingredient unit) -> Tuple ingredient [ unit ])

ingredientTuples :: Meal -> Array (Tuple String String)
ingredientTuples meal = meal.ingredients <#> (\ingredient -> Tuple ingredient.name ingredient.unit)

allIngredientUnitTuples :: Meals -> Array (Tuple String String)
allIngredientUnitTuples meals = concat (ingredientTuples <$> meals)
