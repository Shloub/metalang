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
function is_number(c){
  return c.charCodeAt(0) <= '9'.charCodeAt(0) && c.charCodeAt(0) >= '0'.charCodeAt(0);
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
function npi_(str, len){
  var stack = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    stack[i] = 0;
  var ptrStack = 0;
  var ptrStr = 0;
  while (ptrStr < len)
    if (str[ptrStr] == ' ')
    ptrStr ++;
  else if (is_number(str[ptrStr]))
  {
    var num = 0;
    while (str[ptrStr] != ' ')
    {
      num = num * 10 + str[ptrStr].charCodeAt(0) - '0'.charCodeAt(0);
      ptrStr ++;
    }
    stack[ptrStack] = num;
    ptrStack ++;
  }
  else if (str[ptrStr] == '+')
  {
    stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
    ptrStack --;
    ptrStr ++;
  }
  return stack[0];
}

var len = 0;
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i = 0 ; i <= len - 1; i++)
{
  var tmp = '\000';
  tmp=read_char_();
  tab[i] = tmp;
}
var result = npi_(tab, len);
util.print(result);

