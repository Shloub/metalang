var util = require("util");
var f = new Array(10);
for (var j = 0 ; j <= 10 - 1; j++)
  f[j] = 1;
for (var i = 1 ; i <= 9; i++)
{
  f[i] = f[i] * i * f[i - 1];
  util.print(f[i], " ");
}
var out0 = 0;
util.print("\n");
for (var a = 0 ; a <= 9; a++)
  for (var b = 0 ; b <= 9; b++)
    for (var c = 0 ; c <= 9; c++)
      for (var d = 0 ; d <= 9; d++)
        for (var e = 0 ; e <= 9; e++)
          for (var g = 0 ; g <= 9; g++)
          {
            var sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
            var num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
            if (a == 0)
            {
              sum --;
              if (b == 0)
              {
                sum --;
                if (c == 0)
                {
                  sum --;
                  if (d == 0)
                    sum --;
                }
              }
            }
            if (sum == num && sum != 1 && sum != 2)
            {
              out0 += num;
              util.print(num, " ");
            }
}
util.print("\n", out0, "\n");

