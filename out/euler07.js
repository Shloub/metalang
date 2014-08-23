var util = require("util");
function divisible(n, t, size){
  for (var i = 0 ; i <= size - 1; i++)
    if ((~~(n % t[i])) == 0)
    return 1;
  return 0;
}

function find(n, t, used, nth){
  while (used != nth)
    if (divisible(n, t, used))
    n ++;
  else
  {
    t[used] = n;
    n ++;
    used ++;
  }
  return t[used - 1];
}

var n = 10001;
var t = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
  t[i] = 2;
util.print(find(3, t, 1, n), "\n");

