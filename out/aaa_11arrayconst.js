var util = require("util");

function test(tab, len) {
    for (var i = 0; i < len; i += 1)
        util.print(tab[i], " ");
    util.print("\n");
}

var t = new Array(5);
for (var i = 0; i < 5; i += 1)
    t[i] = 1;
test(t, 5);

