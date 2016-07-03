var util = require("util");
util.print("Hello World");
var a = 5;
util.print((4 + 6) * 2, " \n", a, "foo");
if (1 + ~~(2 * 2 * (3 + 8) / 4) - 2 == 12 && true)
    util.print("True");
else
    util.print("False");
util.print("\n");
if ((3 * (4 + 11) * 2 == 45) == false)
    util.print("True");
else
    util.print("False");
util.print(" ");
if ((2 == 1) == false)
    util.print("True");
else
    util.print("False");
util.print(" ", ~~(~~(5 / 3) / 3), ~~(~~(4 * 1 / 3) / 2 * 1));
if (!(!(a == 0) && !(a == 4)))
    util.print("True");
else
    util.print("False");
if (true && !false && !(true && false))
    util.print("True");
else
    util.print("False");
util.print("\n");

