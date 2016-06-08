var util = require("util");

function fact(n) {
    var prod = 1;
    for (var i = 2; i <= n; i += 1)
        prod *= i;
    return prod;
}


function show(lim, nth) {
    var t = new Array(lim);
    for (var i = 0; i < lim; i += 1)
        t[i] = i;
    var pris = new Array(lim);
    for (var j = 0; j < lim; j += 1)
        pris[j] = false;
    for (var k = 1; k < lim; k += 1)
    {
        var n = fact(lim - k);
        var nchiffre = ~~(nth / n);
        nth = ~~(nth % n);
        for (var l = 0; l < lim; l += 1)
            if (!pris[l])
            {
                if (nchiffre == 0)
                {
                    util.print(l);
                    pris[l] = true;
                }
                nchiffre -= 1;
            }
    }
    for (var m = 0; m < lim; m += 1)
        if (!pris[m])
            util.print(m);
    util.print("\n");
}

show(10, 999999);

