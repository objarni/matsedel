(() => {
  // output/Main/foreign.js
  var simulate = (initialGerms) => (tickGerms) => () => {
    console.log(initialGerms);
    console.log(tickGerms);
    state = initialGerms;
    tick = tickGerms;
    window.requestAnimationFrame(step);
  };
  function render(germs) {
    console.log(germs);
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "red";
    ctx.fillRect(germs[0].age, 100, 50, 25);
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

  // output/Effect.Console/foreign.js
  var log = function(s) {
    return function() {
      console.log(s);
    };
  };

  // output/Main/index.js
  var tick2 = /* @__PURE__ */ map(functorArray)(function(germ) {
    return {
      age: germ.age + 1 | 0,
      name: germ.name
    };
  });
  var main = function __do() {
    log("\u{1F35D}Hej")();
    return simulate([{
      name: "Samuel",
      age: 25
    }])(tick2)();
  };

  // <stdin>
  main();
})();
