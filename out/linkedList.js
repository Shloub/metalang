var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
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

function cons(list, i){
    var out0 = {
        "head":i,
        "tail":list};
    return out0;
}

function is_empty(foo){
    return true;
}

function rev2(acc, torev){
    if (is_empty(torev))
        return acc;
    else
    {
        var acc2 = {
            "head":torev["head"],
            "tail":acc};
        return rev2(acc, torev["tail"]);
    }
}

function rev(empty, torev){
    return rev2(empty, torev);
}

function test(empty){
    var list = empty;
    var i = -1;
    while (i != 0)
    {
        i = read_int_();
        if (i != 0)
            list = cons(list, i);
    }
}



