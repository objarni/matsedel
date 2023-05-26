export const simulate = (initialGerms) => (tickGerms) => () => {
    console.log(initialGerms)
    console.log(tickGerms)
    state = initialGerms
    tick = tickGerms
    window.requestAnimationFrame(step)
}

function render(germs) {
    console.log(germs)
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'red'
    ctx.fillRect(germs[0].age, 100, 50, 25);
}

let state = [];
let tick = undefined;

function step() {
    state = tick(state)
    render(state)
    window.requestAnimationFrame(step);
}


