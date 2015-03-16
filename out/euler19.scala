object euler19
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def is_leap(year : Int): Boolean = {
    return (year % 400) == 0 || ((year % 100) != 0 && (year % 4) == 0);
  }
  
  def ndayinmonth(month : Int, year : Int): Int = {
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
  
  
  def main(args : Array[String])
  {
    var month: Int = 0;
    var year: Int = 1901;
    var dayofweek: Int = 1;
    /* 01-01-1901 : mardi */
    var count: Int = 0;
    while (year != 2001)
    {
      var ndays: Int = ndayinmonth(month, year);
      dayofweek = (dayofweek + ndays) % 7;
      month = month + 1;
      if (month == 12)
      {
        month = 0;
        year = year + 1;
      }
      if ((dayofweek % 7) == 6)
        count = count + 1;
    }
    printf("%d\n", count);
  }
  
}

