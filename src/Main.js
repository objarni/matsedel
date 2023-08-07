export const setMeals = (meals) => () => {
    console.log("setting meals = ", meals)
    let table = document.getElementById('mealsTable');
    meals.forEach(meal => {
        const week = leftist(3)
        const name = leftist(meal.meal)
        let minusButton = aButton('-')
        let plusButton = aButton('+')
        const servingsDiv = aDiv(minusButton, meal.servings, plusButton)
        const row = niceRow(week, name, servingsDiv)
        table.append(row)
    })
}

export const setIngredients = (ingredients) => () => {
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
    div.innerText = text
    return div
}

function rightist(text) {
    const div = document.createElement('div')
    div.className = 'rightist'
    div.innerText = text
    return div
}


// puregerm code below
export const simulate = (initialGerms) => (tickGerms) => () => {
    state = initialGerms
    tick = tickGerms
    window.requestAnimationFrame(step)
}

function render(model) {

    // Clear canvas
    const canvas = document.getElementById('canvas')
    const ctx = canvas.getContext('2d')
    ctx.clearRect(0, 0, canvas.width, canvas.height)

    // Germs
    const germs = model.germs
    ctx.fillStyle = 'green'
    germs.forEach(germ => {
        ctx.fillRect(germ.pos.x, germ.pos.y, 2, 2)
    })

    // Foods
    const foods = model.foods
    ctx.fillStyle = '#ffffff'
    foods.forEach(food => {
        ctx.fillRect(food.x, food.y, 2, 2)
    })
}

let state = []
let tick = undefined

function step() {
    state = tick(state)
    render(state)
    window.requestAnimationFrame(step);
}


