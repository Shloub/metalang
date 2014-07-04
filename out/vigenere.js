
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


function position_alphabet(c){
  var i = c.charCodeAt(0);
  if (i <= 'Z'.charCodeAt(0) && i >= 'A'.charCodeAt(0))
    return i - 'A'.charCodeAt(0);
  else if (i <= 'z'.charCodeAt(0) && i >= 'a'.charCodeAt(0))
    return i - 'a'.charCodeAt(0);
  else
    return -1;
}

function of_position_alphabet(c){
  return String.fromCharCode(c + 'a'.charCodeAt(0));
}

function crypte(taille_cle, cle, taille, message){
  for (var i = 0 ; i <= taille - 1; i++)
  {
    var lettre = position_alphabet(message[i]);
    if (lettre != -1)
    {
      var addon = position_alphabet(cle[~~(i % taille_cle)]);
      var new_ = ~~((addon + lettre) % 26);
      message[i] = of_position_alphabet(new_);
    }
  }
}

var taille_cle = 0;
taille_cle=read_int_();
stdinsep();
var cle = new Array(taille_cle);
for (var index = 0 ; index <= taille_cle - 1; index++)
{
  var out_ = '_';
  out_=read_char_();
  cle[index] = out_;
}
stdinsep();
var taille = 0;
taille=read_int_();
stdinsep();
var message = new Array(taille);
for (var index2 = 0 ; index2 <= taille - 1; index2++)
{
  var out2 = '_';
  out2=read_char_();
  message[index2] = out2;
}
crypte(taille_cle, cle, taille, message);
for (var i = 0 ; i <= taille - 1; i++)
{
  var a = message[i];
  util.print(a);
}
util.print("\n");


