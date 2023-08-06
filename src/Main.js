export const simulate = (initialGerms) => (tickGerms) => () => {
    state = initialGerms
    tick = tickGerms
    window.requestAnimationFrame(step)
}
function spanWithText(text) {
    const span = document.createElement('span')
    span.style = 'width:30%'
    span.innerText = text
    return span
}
export const setIngredients = (ingredients) => () => {
    ingredients.forEach(ingredient => {
        const name = spanWithText(ingredient.name)
        const amount = spanWithText(ingredient.amount)
        const unit = spanWithText(ingredient.unit)

        const row = document.createElement('div')
        row.style['width'] = '100vw'
        row.style['backgroundColor'] = 'lightgrey'
        row.append(name, amount, unit)
        document.getElementById('table').appendChild(row)
    })
    console.log("hello from setIngredients")
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


