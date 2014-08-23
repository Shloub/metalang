var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
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
  return Math.max(a, b);
}

function nbPassePartout(n, passepartout, m, serrures){
  var max_ancient = 0;
  var max_recent = 0;
  for (var i = 0 ; i <= m - 1; i++)
  {
    if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
      max_ancient = serrures[i][1];
    if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
      max_recent = serrures[i][1];
  }
  var max_ancient_pp = 0;
  var max_recent_pp = 0;
  for (var i = 0 ; i <= n - 1; i++)
  {
    var pp = passepartout[i];
    if (pp[0] >= max_ancient && pp[1] >= max_recent)
      return 1;
    max_ancient_pp = max2(max_ancient_pp, pp[0]);
    max_recent_pp = max2(max_recent_pp, pp[1]);
  }
  if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
    return 2;
  else
    return 0;
}

var n = 0;
n=read_int_();
stdinsep();
var passepartout = new Array(n);
for (var i = 0 ; i <= n - 1; i++)
{
  var out0 = new Array(2);
  for (var j = 0 ; j <= 2 - 1; j++)
  {
    var out__ = 0;
    out__=read_int_();
    stdinsep();
    out0[j] = out__;
  }
  passepartout[i] = out0;
}
var m = 0;
m=read_int_();
stdinsep();
var serrures = new Array(m);
for (var k = 0 ; k <= m - 1; k++)
{
  var out1 = new Array(2);
  for (var l = 0 ; l <= 2 - 1; l++)
  {
    var out_ = 0;
    out_=read_int_();
    stdinsep();
    out1[l] = out_;
  }
  serrures[k] = out1;
}
util.print(nbPassePartout(n, passepartout, m, serrures));

