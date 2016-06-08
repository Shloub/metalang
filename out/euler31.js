var util = require("util");

function result(sum, t, maxIndex, cache) {
    if (cache[sum][maxIndex] != 0)
        return cache[sum][maxIndex];
    else
        if (sum == 0 || maxIndex == 0)
            return 1;
        else
        {
            var out0 = 0;
            var div = ~~(sum / t[maxIndex]);
            for (var i = 0; i <= div; i += 1)
                out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
            cache[sum][maxIndex] = out0;
            return out0;
        }
}

var t = new Array(8);
for (var i = 0; i < 8; i += 1)
    t[i] = 0;
t[0] = 1;
t[1] = 2;
t[2] = 5;
t[3] = 10;
t[4] = 20;
t[5] = 50;
t[6] = 100;
t[7] = 200;
var cache = new Array(201);
for (var j = 0; j < 201; j += 1)
{
    var o = new Array(8);
    for (var k = 0; k < 8; k += 1)
        o[k] = 0;
    cache[j] = o;
}
util.print(result(200, t, 7, cache));

