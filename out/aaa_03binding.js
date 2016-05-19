var util = require("util");

function g(i) {
    var j = i * 4;
    if (~~(j % 2) == 1)
      return 0;
    return j;
}


function h(i) {
    util.print(i, "\n");
}

h(14);
var a = 4;
var b = 5;
util.print(a + b);
/* main */
h(15);
a = 2;
b = 1;
util.print(a + b);

