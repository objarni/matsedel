export const simulate = (initialGerms) => (tickGerms) => () => {
    state = initialGerms
    tick = tickGerms
    window.requestAnimationFrame(step)
}
function spanWithText(text) {
    const span = document.createElement('span')
    span.innerText = text
    return span
}
export const setIngredients = (ingredients) => () => {
    ingredients.forEach(ingredient => {
        console.log(ingredient)

        const tableDiv = document.getElementById('table')
        // let name = tableDiv.createElement("span")
        // name.innerText = ingredient.name

        const row = document.createElement('div')

        const name = spanWithText(ingredient.name)
        const amount = spanWithText(ingredient.amount)
        const unit = spanWithText(ingredient.unit)
        row.appendChild(name)
        row.appendChild(amount)
        row.appendChild(unit)
        tableDiv.appendChild(row)
        // const name = document.createElement('span')
        // name.innerText = ingredient.name
        // const amount = document.createElement('span')
        // amount.innerText = '' + ingredient.amount
        // // span.classList.add('bullet');
        // row.appendChild(name);
        // row.appendChild(amount);
        // tableDiv.appendChild(row)

        // let row = table.insertRow(-1);
        // // Create table cells
        // let c1 = row.insertCell(0);
        // let c2 = row.insertCell(1);
        // let c3 = row.insertCell(2);
        //
        // // Add data to c1 and c2
        // c1.innerText = ingredient.name
        // c2.innerText = ingredient.amount
        // c3.innerText = ingredient.unit

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


