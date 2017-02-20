var util = require("util");
function next0(n){
    if (~~(n % 2) == 0)
        return ~~(n / 2);
    else
        return 3 * n + 1;
}
function find(n, m){
    if (n == 1)
        return 1;
    else if (n >= 1000000)
        return 1 + find(next0(n), m);
    else if (m[n] != 0)
        return m[n];
    else
    {
        m[n] = 1 + find(next0(n), m);
        return m[n];
    }
}
var m = new Array(1000000);
for (var j = 0; j < 1000000; j++)
    m[j] = 0;
var max0 = 0;
var maxi = 0;
for (var i = 1; i < 1000; i++)
{
    //  normalement on met 999999 mais ça dépasse les int32... 
    
    var n2 = find(i, m);
    if (n2 > max0)
    {
        max0 = n2;
        maxi = i;
    }
}
util.print(max0, "\n", maxi, "\n");

