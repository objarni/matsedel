
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

}
export const setIngredients = (ingredients) => () => {
    let table = document.getElementById('ingredientsTable');
    ingredients.forEach(ingredient => {
        const name = leftist(ingredient.name)
        const amount = rightist(`${ingredient.amount} ${ingredient.unit}`)
        let div = document.createElement('div');
        div.className = 'nice-row'
        div.append(name, amount)
        table.append(div)
    })
    console.log("hello from setIngredients")
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


