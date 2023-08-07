function niceRow() {
    let div = document.createElement('div');
    div.className = 'nice-row'
    for (let i = 0; i < arguments.length; i++) {
        div.append(arguments[i])
    }
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

export const setMeals = (meals) => () => {
    console.log("setting meals = ", meals)
    let table = document.getElementById('mealsTable');
    meals.forEach(meal => {
        const name = leftist(meal.meal)
        const amount = rightist(`${meal.servings}`)
        const row = niceRow(name, amount)
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


