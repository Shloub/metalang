var util = require("util");

function chiffre_sort(a) {
    if (a < 10)
        return a;
    else
    {
        var b = chiffre_sort(~~(a / 10));
        var c = ~~(a % 10);
        var d = ~~(b % 10);
        var e = ~~(b / 10);
        if (c < d)
            return c + b * 10;
        else
            return d + chiffre_sort(c + e * 10) * 10;
    }
}


function same_numbers(a, b, c, d, e, f) {
    var ca = chiffre_sort(a);
    return ca == chiffre_sort(b) && ca == chiffre_sort(c) && ca == chiffre_sort(d) && ca == chiffre_sort(e) && ca == chiffre_sort(f);
}

var num = 142857;
if (same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5))
    util.print(num, " ", num * 2, " ", num * 3, " ", num * 4, " ", num * 5, " ", num * 6, "\n");

