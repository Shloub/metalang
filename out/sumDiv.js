var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
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

function foo(){
    var a = 0;
    //  test 
    a++;
    //  test 2 
}
function foo2(){
    
}
function foo3(){
    if (1 == 1)
    {
        
    }
}
function sumdiv(n){
    //  On désire renvoyer la somme des diviseurs 
    var out0 = 0;
    //  On déclare un entier qui contiendra la somme 
    for (var i = 1; i <= n; i++)
        //  La boucle : i est le diviseur potentiel
        if (~~(n % i) == 0)
        {
            //  Si i divise 
            out0 += i;
            //  On incrémente 
        }
        else
        {
            //  nop 
        }
    return out0;
    // On renvoie out
}
//  Programme principal 
var n = 0;
n = read_int_();
//  Lecture de l'entier 
util.print(sumdiv(n));

