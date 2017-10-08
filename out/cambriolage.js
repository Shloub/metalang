var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
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

function nbPassePartout(n, passepartout, m, serrures){
    var max_ancient = 0;
    var max_recent = 0;
    for (var i = 0; i < m; i++)
    {
        if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
            max_ancient = serrures[i][1];
        if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
            max_recent = serrures[i][1];
    }
    var max_ancient_pp = 0;
    var max_recent_pp = 0;
    for (var i = 0; i < n; i++)
    {
        var pp = passepartout[i];
        if (pp[0] >= max_ancient && pp[1] >= max_recent)
            return 1;
        max_ancient_pp = Math.max(max_ancient_pp, pp[0]);
        max_recent_pp = Math.max(max_recent_pp, pp[1]);
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
        return 2;
    else
        return 0;
}
var n = read_int_();
stdinsep();
var passepartout = new Array(n);
for (var i = 0; i < n; i++)
{
    var out0 = new Array(2);
    for (var j = 0; j < 2; j++)
    {
        var out01 = read_int_();
        stdinsep();
        out0[j] = out01;
    }
    passepartout[i] = out0;
}
var m = read_int_();
stdinsep();
var serrures = new Array(m);
for (var k = 0; k < m; k++)
{
    var out1 = new Array(2);
    for (var l = 0; l < 2; l++)
    {
        var out_ = read_int_();
        stdinsep();
        out1[l] = out_;
    }
    serrures[k] = out1;
}
util.print(nbPassePartout(n, passepartout, m, serrures));

