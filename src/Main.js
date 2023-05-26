export const simulate = (initialGerms) => (tickGerms) => () => {
    state = initialGerms
    tick = tickGerms
    window.requestAnimationFrame(step)
}

function render(germs) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = 'green'
    let germ = germs[0];
    ctx.fillRect(germ.pos.x, germ.pos.y, 2, 2);
}

let state = [];
let tick = undefined;

function step() {
    state = tick(state)
    render(state)
    window.requestAnimationFrame(step);
}


