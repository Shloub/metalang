var util = require("util");
var n = 10;
/* normalement on doit mettre 20 mais là on se tape un overflow */
n++;
var tab = new Array(n);
for (var i = 0 ; i < n; i++)
{
    var tab2 = new Array(n);
    for (var j = 0 ; j < n; j++)
      tab2[j] = 0;
    tab[i] = tab2;
}
for (var l = 0 ; l < n; l++)
{
    tab[n - 1][l] = 1;
    tab[l][n - 1] = 1;
}
for (var o = 2 ; o <= n; o++)
{
    var r = n - o;
    for (var p = 2 ; p <= n; p++)
    {
        var q = n - p;
        tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
    }
}
for (var m = 0 ; m < n; m++)
{
    for (var k = 0 ; k < n; k++)
      util.print(tab[m][k], " ");
    util.print("\n");
}
util.print(tab[0][0], "\n");

