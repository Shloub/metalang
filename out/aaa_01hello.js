var util = require("util");
util.print("Hello World");
var a = 5;
util.print((4 + 6) * 2, " ", "\n", a, "foo", "");
var b = 1 + ~~((1 + 1) * 2 * (3 + 8) / 4) - (1 - 2) - 3 == 12 && true;
if (b)
  util.print("True");
else
  util.print("False");
util.print("\n");
var c = (3 * (4 + 5 + 6) * 2 == 45) == false;
if (c)
  util.print("True");
else
  util.print("False");
util.print(" ");
var d = (2 == 1) == false;
if (d)
  util.print("True");
else
  util.print("False");
util.print(" ", ~~(~~((4 + 1) / 3) / (2 + 1)), ~~(~~(4 * 1 / 3) / 2 * 1));
var e = !(!(a == 0) && !(a == 4));
if (e)
  util.print("True");
else
  util.print("False");
var f = true && !false && !(true && false);
if (f)
  util.print("True");
else
  util.print("False");
util.print("\n");

