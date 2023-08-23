var globalMeals
var globalIncFn
var globalDecFn
var globalMeals2ingredients

export const run = (meals) => (meals2ingredients) => (meals2unitLess) => (incFn) => (decFn) => () => {
    globalIncFn = incFn
    globalDecFn = decFn
    globalMeals2ingredients = meals2ingredients
    setMeals(meals, meals2unitLess)
}

function setMeals(meals, meals2unitLess) {
    console.log("setting meals = ", meals)

    const unitLess = meals2unitLess(meals)
    setUnitLess(unitLess)

    globalMeals = meals
    let table = document.getElementById('mealsTable');
    table.innerHTML = ''
    meals.forEach(meal => {
        const name = leftist(`<a target="_blank" href="${meal.webPage}">${meal.meal}</a>`)
        let minusButton = aButton('-')
        if(meal.servings > 0)
            minusButton.onclick = () => {
                console.log('-')
                setMeals(globalDecFn(meal.meal)(globalMeals), meals2unitLess)
            }
        let plusButton = aButton('+')
        plusButton.onclick = () => {
            console.log('+')
            setMeals(globalIncFn(meal.meal)(globalMeals), meals2unitLess)
        }
        const servingsDiv = aDiv(minusButton, meal.servings, plusButton)
        const row = niceRow(name, servingsDiv)
        table.append(row)
    })

    const ingredients = globalMeals2ingredients(meals)
    setIngredients(ingredients)
}

function setUnitLess(unitLess) {
    let table = document.getElementById('unitLessTable')
    table.innerHTML = ''
    console.log("setting unitLess = ", unitLess)
    unitLess.forEach(unitLess => {
        const name = leftist(unitLess)
        table.append(niceRow(name))
    })
}

function setIngredients(ingredients) {
    let table = document.getElementById('ingredientsTable')
    table.innerHTML = ''
    console.log("setting ingredients = ", ingredients)
    ingredients.forEach(ingredient => {
        const name = leftist(ingredient.name)
        const amount = rightist(`${ingredient.amount} ${ingredient.unit}`)
        table.append(niceRow(name, amount))
    })
}

function aDiv() {
    let div = document.createElement('div');
    for (let i = 0; i < arguments.length; i++) {
        div.append(arguments[i])
    }
    return div
}

function aButton(text) {
    let theButton = document.createElement('button')
    theButton.style["fontSize"] = "large"
    theButton.innerText = text
    return theButton
}

function niceRow() {
    let div = aDiv(...arguments)
    div.className = 'nice-row'
    return div
}

function leftist(text) {
    const div = document.createElement('div')
    div.className = 'leftist';
    div.innerHTML = text
    return div
}

function rightist(text) {
    const div = document.createElement('div')
    div.className = 'rightist'
    div.innerHTML = text
    return div
}

