
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



function max2(a, b){
  if (a > b)
    return a;
  return b;
}


function read_big_int(){
  util.print("read_big_int");
  var len = 0;
  len=read_int_();
  stdinsep();
  util.print(len, "=len ");
  var sign = '_';
  sign=read_char_();
  util.print(sign, "=sign\n");
  var chiffres = new Array(len);
  for (var d = 0 ; d <= len - 1; d++)
  {
    var c = '_';
    c=read_char_();
    util.print(c, "=c\n");
    chiffres[d] = c.charCodeAt(0) - '0'.charCodeAt(0);
  }
  for (var i = 0 ; i <= Math.floor(len / 2); i++)
  {
    var tmp = chiffres[i];
    chiffres[i] = chiffres[len - 1 - i];
    chiffres[len - 1 - i] = tmp;
  }
  stdinsep();
  var out_ = {
                sign : sign
                ==
                '+',
                chiffres_len : len,
                chiffres : chiffres
  };
  return out_;
}

function print_big_int(a){
  if (a.sign)
    util.print("+");
  else
    util.print("-");
  for (var i = 0 ; i <= a.chiffres_len - 1; i++)
  {
    var e = a.chiffres[i];
    util.print(e);
  }
}

function neg_big_int(a){
  var out_ = {
                sign : !a.sign,
                chiffres_len : a.chiffres_len,
                chiffres : a.chiffres
  };
  return out_;
}

function add_big_int(a, b){
  var len = max2(a.chiffres_len, b.chiffres_len) + 1;
  var retenue = 0;
  var sign = 1;
  var chiffres = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
  {
    var tmp = retenue;
    if (i < a.chiffres_len)
      tmp += a.chiffres[i];
    if (i < b.chiffres_len)
      tmp += b.chiffres[i];
    retenue = Math.floor(tmp / 10);
    chiffres[i] = tmp % 10;
  }
  var out_ = {
                sign : sign,
                chiffres_len : len,
                chiffres : chiffres
  };
  return out_;
}

/*
def @bigint mul_big_int(@bigint a, @bigint b)

end

def @bigint exp_big_int(@bigint a, @bigint b)

end

def @bigint print_big_int(@bigint b)

end
*/
var a = read_big_int();
var b = read_big_int();
print_big_int(add_big_int(a, b));


