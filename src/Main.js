var globalMeals
var globalIncFn
var globalDecFn

export const run = (meals) => (meals2ingredients) => (incFn) => (decFn) => () => {
    globalIncFn = incFn
    globalDecFn = decFn
    setMeals(meals)
    var ingredients = meals2ingredients(meals)
    setIngredients(ingredients)
}

function setMeals(meals) {
    console.log("setting meals = ", meals)
    globalMeals = meals
    let table = document.getElementById('mealsTable');
    table.innerHTML = ''
    meals.forEach(meal => {
        const week = leftist(3)
        const name = leftist(`<a target="_blank" href="${meal.webPage}">${meal.meal}</a>`)
        let minusButton = aButton('-')
        if(meal.servings > 0)
            minusButton.onclick = () => {
                console.log('-')
                setMeals(globalDecFn(meal.meal)(globalMeals))
            }
        let plusButton = aButton('+')
        plusButton.onclick = () => {
            console.log('+')
            setMeals(globalIncFn(meal.meal)(globalMeals))
        }
        const servingsDiv = aDiv(minusButton, meal.servings, plusButton)
        const row = niceRow(week, name, servingsDiv)
        table.append(row)
    })
}

function setIngredients(ingredients) {
    let table = document.getElementById('ingredientsTable');
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

