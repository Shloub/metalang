
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


function copytab(tab, len){
  var o = new Array(len);
  for (var i = 0 ; i <= len - 1; i++)
    o[i] = tab[i];
  return o;
}

function bubblesort(tab, len){
  for (var i = 0 ; i <= len - 1; i++)
    for (var j = i + 1 ; j <= len - 1; j++)
      if (tab[i] > tab[j])
  {
    var tmp = tab[i];
    tab[i] = tab[j];
    tab[j] = tmp;
  }
}

function qsort_(tab, len, i, j){
  if (i < j)
  {
    var i0 = i;
    var j0 = j;
    /* pivot : tab[0] */
    while (i != j)
      if (tab[i] > tab[j])
    {
      if (i == j - 1)
      {
        /* on inverse simplement*/
        var tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
        i ++;
      }
      else
      {
        /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
        var tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tab[i + 1];
        tab[i + 1] = tmp;
        i ++;
      }
    }
    else
      j --;
    qsort_(tab, len, i0, i - 1);
    qsort_(tab, len, i + 1, j0);
  }
}

var len = 2;
len=read_int_();
stdinsep();
var tab = new Array(len);
for (var i_ = 0 ; i_ <= len - 1; i_++)
{
  var tmp = 0;
  tmp=read_int_();
  stdinsep();
  tab[i_] = tmp;
}
var tab2 = copytab(tab, len);
bubblesort(tab2, len);
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(tab2[i], " ");
}
util.print("\n");
var tab3 = copytab(tab, len);
qsort_(tab3, len, 0, len - 1);
for (var i = 0 ; i <= len - 1; i++)
{
  util.print(tab3[i], " ");
}
util.print("\n");


