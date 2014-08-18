function next_(n){
  if ((~~(n % 2)) == 0)
    return ~~(n / 2);
  else
    return 3 * n + 1;
}

function find(n, m){
  if (n == 1)
    return 1;
  else if (n >= 1000000)
    return 1 + find(next_(n), m);
  else if (m[n] != 0)
    return m[n];
  else
  {
    m[n] = 1 + find(next_(n), m);
    return m[n];
  }
}

var a = 1000000;
var m = new Array(a);
for (var j = 0 ; j <= a - 1; j++)
  m[j] = 0;
var max_ = 0;
var maxi = 0;
for (var i = 1 ; i <= 999; i++)
{
  /* normalement on met 999999 mais ça dépasse les int32... */
  var n2 = find(i, m);
  if (n2 > max_)
  {
    max_ = n2;
    maxi = i;
  }
}
util.print(max_, "\n", maxi, "\n");

