var util = require("util");

function f(tuple0){
  var e = {
    tuple_int_int_field_0 : tuple0.tuple_int_int_field_0 + 1,
    tuple_int_int_field_1 : tuple0.tuple_int_int_field_1 + 1
  };
  return e;
}

var g = {
  tuple_int_int_field_0 : 0,
  tuple_int_int_field_1 : 1
};
var t = f(g);
util.print(t.tuple_int_int_field_0, " -- ", t.tuple_int_int_field_1, "--\n");

