var util = require("util");

var lim = 100;
var sum = ~~(lim * (lim + 1) / 2);
var carressum = sum * sum;
var sumcarres = ~~(lim * (lim + 1) * (2 * lim + 1) / 6);
util.print(carressum - sumcarres);

