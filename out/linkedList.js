
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



function cons(list, i){
  var out_ = {
    head : i,
    tail : list
  };
  return out_;
}

function rev2(empty, acc, torev){
  if (torev == empty)
    return acc;
  else
  {
    var acc2 = {
      head : torev.head,
      tail : acc
    };
    return rev2(empty, acc, torev.tail);
  }
}

function rev(empty, torev){
  return rev2(empty, empty, torev);
}

function test(empty){
  var list = empty;
  var i = -1;
  while (i != 0)
  {
    i=read_int_();
    if (i != 0)
      list = cons(list, i);
  }
}




