var util = require("util");
function palindrome2(pow2, n){
  var t = new Array(20);
  for (var i = 0 ; i <= 20 - 1; i++)
    t[i] = (~~((~~(n / pow2[i])) % 2)) == 1;
  var nnum = 0;
  for (var j = 1 ; j <= 19; j++)
    if (t[j])
    nnum = j;
  for (var k = 0 ; k <= ~~(nnum / 2); k++)
    if (t[k] != t[nnum - k])
    return 0;
  return 1;
}

var p = 1;
var pow2 = new Array(20);
for (var i = 0 ; i <= 20 - 1; i++)
{
  p *= 2;
  pow2[i] = ~~(p / 2);
}
var sum = 0;
for (var d = 1 ; d <= 9; d++)
{
  if (palindrome2(pow2, d))
  {
    util.print(d, "\n");
    sum += d;
  }
  if (palindrome2(pow2, d * 10 + d))
  {
    util.print(d * 10 + d, "\n");
    sum += d * 10 + d;
  }
}
for (var a0 = 0 ; a0 <= 4; a0++)
{
  var a = a0 * 2 + 1;
  for (var b = 0 ; b <= 9; b++)
  {
    for (var c = 0 ; c <= 9; c++)
    {
      var num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a;
      if (palindrome2(pow2, num0))
      {
        util.print(num0, "\n");
        sum += num0;
      }
      var num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a;
      if (palindrome2(pow2, num1))
      {
        util.print(num1, "\n");
        sum += num1;
      }
    }
    var num2 = a * 100 + b * 10 + a;
    if (palindrome2(pow2, num2))
    {
      util.print(num2, "\n");
      sum += num2;
    }
    var num3 = a * 1000 + b * 100 + b * 10 + a;
    if (palindrome2(pow2, num3))
    {
      util.print(num3, "\n");
      sum += num3;
    }
  }
}
util.print("sum=", sum, "\n");

