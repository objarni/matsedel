(() => {
  // output/Main/foreign.js
  var simulate = (initialGerms) => (tickGerms) => () => {
    state = initialGerms;
    tick = tickGerms;
    window.requestAnimationFrame(step);
  };
  function render(model) {
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    const germs = model.germs;
    ctx.fillStyle = "green";
    germs.forEach((germ) => {
      ctx.fillRect(germ.pos.x, germ.pos.y, 2, 2);
    });
    const foods = model.foods;
    ctx.fillStyle = "#ffffff";
    foods.forEach((food) => {
      ctx.fillRect(food.x, food.y, 2, 2);
    });
  }
  var state = [];
  var tick = void 0;
  function step() {
    state = tick(state);
    render(state);
    window.requestAnimationFrame(step);
  }

  // output/Data.Functor/foreign.js
  var arrayMap = function(f) {
    return function(arr) {
      var l = arr.length;
      var result = new Array(l);
      for (var i = 0; i < l; i++) {
        result[i] = f(arr[i]);
      }
      return result;
    };
  };

  // output/Data.Functor/index.js
  var map = function(dict) {
    return dict.map;
  };
  var functorArray = {
    map: arrayMap
  };

  // output/Data.Number/foreign.js
  var cos = Math.cos;
  var sin = Math.sin;

  // output/Data.Bounded/foreign.js
  var topChar = String.fromCharCode(65535);
  var bottomChar = String.fromCharCode(0);
  var topNumber = Number.POSITIVE_INFINITY;
  var bottomNumber = Number.NEGATIVE_INFINITY;

  // output/Main/index.js
  var map2 = /* @__PURE__ */ map(functorArray);
  var tickGerm = function(germ) {
    var dy = sin(germ.dir);
    var dx = cos(germ.dir);
    return {
      pos: {
        x: germ.pos.x + dx,
        y: germ.pos.y + dy
      },
      dir: germ.dir,
      age: germ.age
    };
  };
  var tick2 = function(m) {
    return {
      germs: map2(tickGerm)(m.germs),
      foods: m.foods
    };
  };
  var main = /* @__PURE__ */ function() {
    var germs = [{
      pos: {
        x: 50,
        y: 50
      },
      dir: 0.15,
      age: 25
    }];
    return simulate({
      germs,
      foods: [{
        x: 1,
        y: 1
      }]
    })(tick2);
  }();

  // <stdin>
  main();
})();
