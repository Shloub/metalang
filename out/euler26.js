var util = require("util");
function periode(restes, len, a, b){
  while (a != 0)
  {
    var chiffre = ~~(a / b);
    var reste = ~~(a % b);
    for (var i = 0 ; i <= len - 1; i++)
      if (restes[i] == reste)
      return len - i;
    restes[len] = reste;
    len ++;
    a = reste * 10;
  }
  return 0;
}

var t = new Array(1000);
for (var j = 0 ; j <= 1000 - 1; j++)
  t[j] = 0;
var m = 0;
var mi = 0;
for (var i = 1 ; i <= 1000; i++)
{
  var p = periode(t, 0, 1, i);
  if (p > m)
  {
    mi = i;
    m = p;
  }
}
util.print(mi, "\n", m, "\n");

