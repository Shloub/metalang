var util = require("util");
function exp0(a, e){
  var o = 1;
  for (var i = 1 ; i <= e; i++)
    o *= a;
  return o;
}

function e(t, n){
  for (var i = 1 ; i <= 8; i++)
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
for (var i = 0 ; i <= 9 - 1; i++)
  t[i] = exp0(10, i) - exp0(10, i - 1);
for (var i2 = 1 ; i2 <= 8; i2++)
{
  util.print(i2, " => ", t[i2], "\n");
}
for (var j = 0 ; j <= 80; j++)
  util.print(e(t, j));
util.print("\n");
for (var k = 1 ; k <= 50; k++)
  util.print(k);
util.print("\n");
for (var j2 = 169 ; j2 <= 220; j2++)
  util.print(e(t, j2));
util.print("\n");
for (var k2 = 90 ; k2 <= 110; k2++)
  util.print(k2);
util.print("\n");
var out0 = 1;
for (var l = 0 ; l <= 6; l++)
{
  var puiss = exp0(10, l);
  var v = e(t, puiss - 1);
  out0 *= v;
  util.print("10^", l, "=", puiss, " v=", v, "\n");
}
util.print(out0, "\n");

