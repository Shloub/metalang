var util = require("util");

function pgcd(a, b) {
    var c = Math.min(a, b);
    var d = Math.max(a, b);
    var reste = ~~(d % c);
    if (reste == 0)
        return c;
    else
        return pgcd(c, reste);
}

var top = 1;
var bottom = 1;
for (var i = 1; i <= 9; i += 1)
    for (var j = 1; j <= 9; j += 1)
        for (var k = 1; k <= 9; k += 1)
            if (i != j && j != k)
            {
                var a = i * 10 + j;
                var b = j * 10 + k;
                if (a * k == i * b)
                {
                    util.print(a, "/", b, "\n");
                    top *= a;
                    bottom *= b;
                }
            }
util.print(top, "/", bottom, "\n");
var p = pgcd(top, bottom);
util.print("pgcd=", p, "\n", ~~(bottom / p), "\n");

