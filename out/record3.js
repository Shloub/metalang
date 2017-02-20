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

function mktoto(v1){
    var t = {
        "foo":v1,
        "bar":0,
        "blah":0};
    return t;
}
function result(t, len){
    var out0 = 0;
    for (var j = 0; j < len; j++)
    {
        t[j]["blah"]++;
        out0 = out0 + t[j]["foo"] + t[j]["blah"] * t[j]["bar"] + t[j]["bar"] * t[j]["foo"];
    }
    return out0;
}
var t = new Array(4);
for (var i = 0; i < 4; i++)
    t[i] = mktoto(i);
t[0]["bar"] = read_int_();
stdinsep();
t[1]["blah"] = read_int_();
var titi = result(t, 4);
util.print(titi, t[2]["blah"]);

