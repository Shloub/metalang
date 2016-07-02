var util = require("util");

function f(tuple0){
    var c = tuple0;
    var a = c["tuple_int_int_field_0"];
    var b = c["tuple_int_int_field_1"];
    var d = {
        "tuple_int_int_field_0":a + 1,
        "tuple_int_int_field_1":b + 1};
    return d;
}

var e = {
    "tuple_int_int_field_0":0,
    "tuple_int_int_field_1":1};
var t = f(e);
var g = t;
var a = g["tuple_int_int_field_0"];
var b = g["tuple_int_int_field_1"];
util.print(a, " -- ", b, "--\n");

