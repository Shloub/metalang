var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
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
    for (var i = 0; i < taille; i++)
    {
        var lettre = position_alphabet(message[i]);
        if (lettre != -1)
        {
            var addon = position_alphabet(cle[~~(i % taille_cle)]);
            var new0 = ~~((addon + lettre) % 26);
            message[i] = of_position_alphabet(new0);
        }
    }
}
var taille_cle = read_int_();
stdinsep();
var cle = new Array(taille_cle);
for (var index = 0; index < taille_cle; index++)
{
    var out0 = read_char_();
    cle[index] = out0;
}
stdinsep();
var taille = read_int_();
stdinsep();
var message = new Array(taille);
for (var index2 = 0; index2 < taille; index2++)
{
    var out2 = read_char_();
    message[index2] = out2;
}
crypte(taille_cle, cle, taille, message);
for (var i = 0; i < taille; i++)
    util.print(message[i]);
util.print("\n");

