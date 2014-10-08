var util = require("util");

function f(tuple0){
  var c = tuple0;
  var e = {
    tuple_int_int_field_0 : c.tuple_int_int_field_0 + 1,
    tuple_int_int_field_1 : c.tuple_int_int_field_1 + 1
  };
  return e;
}

var g = {
  tuple_int_int_field_0 : 0,
  tuple_int_int_field_1 : 1
};
var t = f(g);
var d = t;
util.print(d.tuple_int_int_field_0, " -- ", d.tuple_int_int_field_1, "--\n");

