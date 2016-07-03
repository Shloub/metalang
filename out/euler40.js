var util = require("util");
function exp0(a, e){
    var o = 1;
    for (var i = 1; i <= e; i += 1)
        o *= a;
    return o;
}

function e(t, n){
    for (var i = 1; i < 9; i += 1)
        if (n >= t[i] * i)
            n -= t[i] * i;
        else
        {
            var nombre = exp0(10, i - 1) + ~~(n / i);
            var chiffre = i - 1 - ~~(n % i);
            return ~~(~~(nombre / exp0(10, chiffre)) % 10);
        }
    return -1;
}

var t = new Array(9);
for (var i = 0; i < 9; i += 1)
    t[i] = exp0(10, i) - exp0(10, i - 1);
for (var i2 = 1; i2 < 9; i2 += 1)
    util.print(i2, " => ", t[i2], "\n");
for (var j = 0; j < 81; j += 1)
    util.print(e(t, j));
util.print("\n");
for (var k = 1; k < 51; k += 1)
    util.print(k);
util.print("\n");
for (var j2 = 169; j2 < 221; j2 += 1)
    util.print(e(t, j2));
util.print("\n");
for (var k2 = 90; k2 < 111; k2 += 1)
    util.print(k2);
util.print("\n");
var out0 = 1;
for (var l = 0; l < 7; l += 1)
{
    var puiss = exp0(10, l);
    var v = e(t, puiss - 1);
    out0 *= v;
    util.print("10^", l, "=", puiss, " v=", v, "\n");
}
util.print(out0, "\n");

