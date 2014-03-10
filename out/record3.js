
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int_ = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}



function mktoto(v1){
  var t_ = {
              foo : v1,
              bar : 0,
              blah : 0
  };
  return t_;
}

function result(t_, len){
  var out_ = 0;
  for (var j = 0 ; j <= len - 1; j++)
  {
    t_[j].blah = t_[j].blah + 1;
    out_ = out_ + t_[j].foo + t_[j].blah * t_[j].bar + t_[j].bar * t_[j].foo;
  }
  return out_;
}

var a = 4;
var t_ = new Array(a);
for (var i = 0 ; i <= a - 1; i++)
  t_[i] = mktoto(i);
t_[0].bar=read_int_();
stdinsep();
t_[1].blah=read_int_();
var b = result(t_, 4);
util.print(b);
var c = t_[2].blah;
util.print(c);


