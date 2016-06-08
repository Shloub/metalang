var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\n\t\s]/g))
        current_char = read_char0();
}
function read_int_(){
  if (current_char == null) current_char = read_char0();
  var sign = 1;
  if (current_char == '-'){
     current_char = read_char0();
     sign = -1;
  }
  var out = 0;
  while (true){
    if (current_char.match(/[0-9]/g)){
      out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
      current_char = read_char0();
    }else{
      return out * sign;
    }
  }
}

function find(n, m, x, y, dx, dy) {
    if (x < 0 || x == 20 || y < 0 || y == 20)
        return -1;
    else
        if (n == 0)
            return 1;
        else
            return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}


var directions = new Array(8);
for (var i = 0; i < 8; i += 1)
    if (i == 0)
    {
        var c = {
            "tuple_int_int_field_0":0,
            "tuple_int_int_field_1":1};
        directions[i] = c;
    }
    else
        if (i == 1)
        {
            var d = {
                "tuple_int_int_field_0":1,
                "tuple_int_int_field_1":0};
            directions[i] = d;
        }
        else
            if (i == 2)
            {
                var e = {
                    "tuple_int_int_field_0":0,
                    "tuple_int_int_field_1":-1};
                directions[i] = e;
            }
            else
                if (i == 3)
                {
                    var f = {
                        "tuple_int_int_field_0":-1,
                        "tuple_int_int_field_1":0};
                    directions[i] = f;
                }
                else
                    if (i == 4)
                    {
                        var g = {
                            "tuple_int_int_field_0":1,
                            "tuple_int_int_field_1":1};
                        directions[i] = g;
                    }
                    else
                        if (i == 5)
                        {
                            var h = {
                                "tuple_int_int_field_0":1,
                                "tuple_int_int_field_1":-1};
                            directions[i] = h;
                        }
                        else
                            if (i == 6)
                            {
                                var k = {
                                    "tuple_int_int_field_0":-1,
                                    "tuple_int_int_field_1":1};
                                directions[i] = k;
                            }
                            else
                            {
                                var l = {
                                    "tuple_int_int_field_0":-1,
                                    "tuple_int_int_field_1":-1};
                                directions[i] = l;
                            }
var max0 = 0;
var m = new Array(20);
for (var o = 0; o < 20; o += 1)
{
    var p = new Array(20);
    for (var q = 0; q < 20; q += 1)
    {
        p[q] = read_int_();
        stdinsep();
    }
    m[o] = p;
}
for (var j = 0; j <= 7; j += 1)
{
    var r = directions[j];
    var dx = r["tuple_int_int_field_0"];
    var dy = r["tuple_int_int_field_1"];
    for (var x = 0; x <= 19; x += 1)
        for (var y = 0; y <= 19; y += 1)
            max0 = Math.max(max0, find(4, m, x, y, dx, dy));
}
util.print(max0, "\n");

