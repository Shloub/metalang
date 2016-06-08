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

function is_triangular(n) {
    /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
    var a = Math.floor(Math.sqrt(n * 2));
    return a * (a + 1) == n * 2;
}


function score() {
    stdinsep();
    var len = read_int_();
    stdinsep();
    var sum = 0;
    for (var i = 1; i <= len; i += 1)
    {
        var c = read_char_();
        sum += c.charCodeAt(0) - 'A'.charCodeAt(0) + 1;
        /*		print c print " " print sum print " " */
    }
    if (is_triangular(sum))
        return 1;
    else
        return 0;
}

for (var i = 1; i <= 55; i += 1)
    if (is_triangular(i))
        util.print(i, " ");
util.print("\n");
var sum = 0;
var n = read_int_();
for (var i = 1; i <= n; i += 1)
    sum += score();
util.print(sum, "\n");

