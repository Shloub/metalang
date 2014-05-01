
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


function is_leap(year){
  return (~~(year % 400)) == 0 || ((~~(year % 100)) != 0 && (~~(year % 4)) == 0);
}

function ndayinmonth(month, year){
  if (month == 0)
    return 31;
  else if (month == 1)
  {
    if (is_leap(year))
      return 29;
    else
      return 28;
  }
  else if (month == 2)
    return 31;
  else if (month == 3)
    return 30;
  else if (month == 4)
    return 31;
  else if (month == 5)
    return 30;
  else if (month == 6)
    return 31;
  else if (month == 7)
    return 31;
  else if (month == 8)
    return 30;
  else if (month == 9)
    return 31;
  else if (month == 10)
    return 30;
  else if (month == 11)
    return 31;
  return 0;
}

var month = 0;
var year = 1901;
var dayofweek = 1;
/* 01-01-1901 : mardi */
var count = 0;
while (year != 2001)
{
  var ndays = ndayinmonth(month, year);
  dayofweek = ~~((dayofweek + ndays) % 7);
  month ++;
  if (month == 12)
  {
    month = 0;
    year ++;
  }
  if ((~~(dayofweek % 7)) == 6)
    count ++;
}
util.print(count, "\n");


