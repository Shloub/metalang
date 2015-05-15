var util = require("util");
function test(tab, len){
  for (var i = 0 ; i <= len - 1; i++)
  {
    util.print(tab[i], " ");
  }
  util.print("\n");
}

var t = new Array(5);
for (var i = 0 ; i <= 5 - 1; i++)
  t[i] = 1;
test(t, 5);

