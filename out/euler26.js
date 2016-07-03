var util = require("util");
function periode(restes, len, a, b){
    while (a != 0)
    {
        var chiffre = ~~(a / b);
        var reste = ~~(a % b);
        for (var i = 0; i < len; i += 1)
            if (restes[i] == reste)
                return len - i;
        restes[len] = reste;
        len += 1;
        a = reste * 10;
    }
    return 0;
}

var t = new Array(1000);
for (var j = 0; j < 1000; j += 1)
    t[j] = 0;
var m = 0;
var mi = 0;
for (var i = 1; i < 1001; i += 1)
{
    var p = periode(t, 0, 1, i);
    if (p > m)
    {
        mi = i;
        m = p;
    }
}
util.print(mi, "\n", m, "\n");

