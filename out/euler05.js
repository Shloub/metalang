var util = require("util");

function primesfactors(n) {
    var tab = new Array(n + 1);
    for (var i = 0 ; i < n + 1; i++)
      tab[i] = 0;
    var d = 2;
    while (n != 1 && d * d <= n)
      if (~~(n % d) == 0)
    {
        tab[d] = tab[d] + 1;
        n = ~~(n / d);
    }
    else
      d++;
    tab[n] = tab[n] + 1;
    return tab;
}

var lim = 20;
var o = new Array(lim + 1);
for (var m = 0 ; m < lim + 1; m++)
  o[m] = 0;
for (var i = 1 ; i <= lim; i++)
{
    var t = primesfactors(i);
    for (var j = 1 ; j <= i; j++)
      o[j] = Math.max(o[j], t[j]);
}
var product = 1;
for (var k = 1 ; k <= lim; k++)
  for (var l = 1 ; l <= o[k]; l++)
    product *= k;
util.print(product, "\n");

