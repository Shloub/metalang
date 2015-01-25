var util = require("util");
function eratostene(t, max0){
  var sum = 0;
  for (var i = 2 ; i <= max0 - 1; i++)
    if (t[i] == i)
  {
    sum += i;
    if (~~(max0 / i) > i)
    {
      var j = i * i;
      while (j < max0 && j > 0)
      {
        t[j] = 0;
        j += i;
      }
    }
  }
  return sum;
}

var n = 100000;
/* normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages */
var t = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
  t[i] = i;
t[1] = 0;
util.print(eratostene(t, n), "\n");

