var util = require("util");
function triangle(n){
    if (~~(n % 2) == 0)
        return ~~(n / 2) * (n + 1);
    else
        return n * ~~((n + 1) / 2);
}
function penta(n){
    if (~~(n % 2) == 0)
        return ~~(n / 2) * (3 * n - 1);
    else
        return ~~((3 * n - 1) / 2) * n;
}
function hexa(n){
    return n * (2 * n - 1);
}
function findPenta2(n, a, b){
    if (b == a + 1)
        return penta(a) == n || penta(b) == n;
    var c = ~~((a + b) / 2);
    var p = penta(c);
    if (p == n)
        return true;
    else if (p < n)
        return findPenta2(n, c, b);
    else
        return findPenta2(n, a, c);
}
function findHexa2(n, a, b){
    if (b == a + 1)
        return hexa(a) == n || hexa(b) == n;
    var c = ~~((a + b) / 2);
    var p = hexa(c);
    if (p == n)
        return true;
    else if (p < n)
        return findHexa2(n, c, b);
    else
        return findHexa2(n, a, c);
}
for (var n = 285; n < 55386; n++)
{
    var t = triangle(n);
    if (findPenta2(t, ~~(n / 5), n) && findHexa2(t, ~~(n / 5), ~~(n / 2) + 10))
        util.print(n, "\n", t, "\n");
}

