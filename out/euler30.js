var util = require("util");
/*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
var p = new Array(10);
for (var i = 0; i < 10; i += 1)
    p[i] = i * i * i * i * i;
var sum = 0;
for (var a = 0; a <= 9; a += 1)
    for (var b = 0; b <= 9; b += 1)
        for (var c = 0; c <= 9; c += 1)
            for (var d = 0; d <= 9; d += 1)
                for (var e = 0; e <= 9; e += 1)
                    for (var f = 0; f <= 9; f += 1)
                    {
                        var s = p[a] + p[b] + p[c] + p[d] + p[e] + p[f];
                        var r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000;
                        if (s == r && r != 1)
                        {
                            util.print(f, e, d, c, b, a, " ", r, "\n");
                            sum += r;
                        }
                    }
util.print(sum);

