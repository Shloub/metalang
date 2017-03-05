var util = require("util");

var a = 1;
var b = 2;
var sum = 0;
while (a < 4000000)
{
    if (~~(a % 2) == 0)
        sum += a;
    var c = a;
    a = b;
    b += c;
}
util.print(sum, "\n");

