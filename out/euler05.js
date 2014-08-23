var util = require("util");
function max2(a, b){
  return Math.max(a, b);
}

function primesfactors(n){
  var c = n + 1;
  var tab = new Array(c);
  for (var i = 0 ; i <= c - 1; i++)
    tab[i] = 0;
  var d = 2;
  while (n != 1 && d * d <= n)
    if ((~~(n % d)) == 0)
  {
    tab[d] = tab[d] + 1;
    n = ~~(n / d);
  }
  else
    d ++;
  tab[n] = tab[n] + 1;
  return tab;
}

var lim = 20;
var e = lim + 1;
var o = new Array(e);
for (var m = 0 ; m <= e - 1; m++)
  o[m] = 0;
for (var i = 1 ; i <= lim; i++)
{
  var t = primesfactors(i);
  for (var j = 1 ; j <= i; j++)
    o[j] = max2(o[j], t[j]);
}
var product = 1;
for (var k = 1 ; k <= lim; k++)
  for (var l = 1 ; l <= o[k]; l++)
    product *= k;
util.print(product, "\n");

