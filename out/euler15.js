
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



var n = 10;
/* normalement on doit mettre 20 mais là on se tape un overflow */
n ++;
var tab = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
{
  var tab2 = new Array(n);
  for (var j = 0 ; j <= n - 1; j++)
    tab2[j] = 0;
  tab[i] = tab2;
}
for (var l = 0 ; l <= n - 1; l++)
{
  tab[n - 1][l] = 1;
  tab[l][n - 1] = 1;
}
for (var o = 2 ; o <= n; o++)
{
  var r = n - o;
  for (var p = 2 ; p <= n; p++)
  {
    var q = n - p;
    tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
  }
}
for (var m = 0 ; m <= n - 1; m++)
{
  for (var k = 0 ; k <= n - 1; k++)
  {
    var a = tab[m][k];
    util.print(a, " ");
  }
  util.print("\n");
}
var b = tab[0][0];
util.print(b, "\n");


