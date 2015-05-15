var util = require("util");
var sum = 0;
for (var i = 0 ; i <= 999; i++)
  if (~~(i % 3) == 0 || ~~(i % 5) == 0)
  sum += i;
util.print(sum, "\n");

