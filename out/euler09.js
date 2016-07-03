var util = require("util");
/*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
for (var a = 1; a < 1001; a++)
    for (var b = a + 1; b < 1001; b++)
    {
        var c = 1000 - a - b;
        var a2b2 = a * a + b * b;
        var cc = c * c;
        if (cc == a2b2 && c > a)
            util.print(a, "\n", b, "\n", c, "\n", a * b * c, "\n");
    }

