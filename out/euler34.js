var util = require("util");

var f = new Array(10);
for (var j = 0; j < 10; j++)
    f[j] = 1;
for (var i = 1; i < 10; i++)
{
    f[i] *= i * f[i - 1];
    util.print(f[i], " ");
}
var out0 = 0;
util.print("\n");
for (var a = 0; a < 10; a++)
    for (var b = 0; b < 10; b++)
        for (var c = 0; c < 10; c++)
            for (var d = 0; d < 10; d++)
                for (var e = 0; e < 10; e++)
                    for (var g = 0; g < 10; g++)
                    {
                        var sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
                        var num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                        if (a == 0)
                        {
                            sum--;
                            if (b == 0)
                            {
                                sum--;
                                if (c == 0)
                                {
                                    sum--;
                                    if (d == 0)
                                        sum--;
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

