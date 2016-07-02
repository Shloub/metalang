var util = require("util");
/*
La suite de fibonaci
*/
function fibo(a, b, i){
    var out_ = 0;
    var a2 = a;
    var b2 = b;
    for (var j = 0; j <= i + 1; j += 1)
    {
        util.print(j);
        out_ += a2;
        var tmp = b2;
        b2 += a2;
        a2 = tmp;
    }
    return out_;
}

util.print(fibo(1, 2, 4));

