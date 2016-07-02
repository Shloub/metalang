var util = require("util");
function divisible(n, t, size){
    for (var i = 0; i < size; i += 1)
        if (~~(n % t[i]) == 0)
            return true;
    return false;
}

function find(n, t, used, nth){
    while (used != nth)
        if (divisible(n, t, used))
            n += 1;
        else
        {
            t[used] = n;
            n += 1;
            used += 1;
        }
    return t[used - 1];
}

var n = 10001;
var t = new Array(n);
for (var i = 0; i < n; i += 1)
    t[i] = 2;
util.print(find(3, t, 1, n), "\n");

