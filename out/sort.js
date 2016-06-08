var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    return fs.readSync(process.stdin.fd, 1)[0];
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

function copytab(tab, len) {
    var o = new Array(len);
    for (var i = 0; i < len; i += 1)
        o[i] = tab[i];
    return o;
}


function bubblesort(tab, len) {
    for (var i = 0; i < len; i += 1)
        for (var j = i + 1; j < len; j += 1)
            if (tab[i] > tab[j])
            {
                var tmp = tab[i];
                tab[i] = tab[j];
                tab[j] = tmp;
            }
}


function qsort0(tab, len, i, j) {
    if (i < j)
    {
        var i0 = i;
        var j0 = j;
        /* pivot : tab[0] */
        while (i != j)
            if (tab[i] > tab[j])
                if (i == j - 1)
                {
                    /* on inverse simplement*/
                    var tmp = tab[i];
                    tab[i] = tab[j];
                    tab[j] = tmp;
                    i += 1;
                }
                else
                {
                    /* on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] */
                    var tmp = tab[i];
                    tab[i] = tab[j];
                    tab[j] = tab[i + 1];
                    tab[i + 1] = tmp;
                    i += 1;
                }
            else
                j -= 1;
        qsort0(tab, len, i0, i - 1);
        qsort0(tab, len, i + 1, j0);
    }
}

var len = 2;
len = read_int_();
stdinsep();
var tab = new Array(len);
for (var i_ = 0; i_ < len; i_ += 1)
{
    var tmp = 0;
    tmp = read_int_();
    stdinsep();
    tab[i_] = tmp;
}
var tab2 = copytab(tab, len);
bubblesort(tab2, len);
for (var i = 0; i < len; i += 1)
    util.print(tab2[i], " ");
util.print("\n");
var tab3 = copytab(tab, len);
qsort0(tab3, len, 0, len - 1);
for (var i = 0; i < len; i += 1)
    util.print(tab3[i], " ");
util.print("\n");

