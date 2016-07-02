var util = require("util");
function is_leap(year){
    return ~~(year % 400) == 0 || ~~(year % 100) != 0 && ~~(year % 4) == 0;
}

function ndayinmonth(month, year){
    if (month == 0)
        return 31;
    else if (month == 1)
        if (is_leap(year))
            return 29;
        else
            return 28;
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
    month += 1;
    if (month == 12)
    {
        month = 0;
        year += 1;
    }
    if (~~(dayofweek % 7) == 6)
        count += 1;
}
util.print(count, "\n");

