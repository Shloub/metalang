var util = require("util");
function h(i){
    /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
    var j = i - 2;
    while (j <= i + 2)
    {
        if (~~(i % j) == 5)
            return true;
        j++;
    }
    return false;
}
var j = 0;
for (var k = 0; k < 11; k++)
{
    j += k;
    util.print(j, "\n");
}
var i = 4;
while (i < 10)
{
    util.print(i);
    i++;
    j += i;
}
util.print(j, i, "FIN TEST\n");

