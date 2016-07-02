var util = require("util");
function primesfactors(n){
    var tab = new Array(n + 1);
    for (var i = 0; i <= n; i += 1)
        tab[i] = 0;
    var d = 2;
    while (n != 1 && d * d <= n)
        if (~~(n % d) == 0)
        {
            tab[d] += 1;
            n = ~~(n / d);
        }
        else
            d += 1;
    tab[n] += 1;
    return tab;
}

var lim = 20;
var o = new Array(lim + 1);
for (var m = 0; m <= lim; m += 1)
    o[m] = 0;
for (var i = 1; i <= lim; i += 1)
{
    var t = primesfactors(i);
    for (var j = 1; j <= i; j += 1)
        o[j] = Math.max(o[j], t[j]);
}
var product = 1;
for (var k = 1; k <= lim; k += 1)
    for (var l = 1; l <= o[k]; l += 1)
        product *= k;
util.print(product, "\n");

