object euler17
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

  
  def main(args : Array[String])
  {
    var one: Int = 3;
    var two: Int = 3;
    var three: Int = 5;
    var four: Int = 4;
    var five: Int = 4;
    var six: Int = 3;
    var seven: Int = 5;
    var eight: Int = 5;
    var nine: Int = 4;
    var ten: Int = 3;
    var eleven: Int = 6;
    var twelve: Int = 6;
    var thirteen: Int = 8;
    var fourteen: Int = 8;
    var fifteen: Int = 7;
    var sixteen: Int = 7;
    var seventeen: Int = 9;
    var eighteen: Int = 8;
    var nineteen: Int = 8;
    var twenty: Int = 6;
    var thirty: Int = 6;
    var forty: Int = 5;
    var fifty: Int = 5;
    var sixty: Int = 5;
    var seventy: Int = 7;
    var eighty: Int = 6;
    var ninety: Int = 6;
    var hundred: Int = 7;
    var thousand: Int = 8;
    printf("%d\n", one + two + three + four + five);
    var hundred_and: Int = 10;
    var one_to_nine: Int = one + two + three + four + five + six + seven + eight + nine;
    printf("%d\n", one_to_nine);
    var one_to_ten: Int = one_to_nine + ten;
    var one_to_twenty: Int = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty;
    var one_to_thirty: Int = one_to_twenty + twenty * 9 + one_to_nine + thirty;
    var one_to_forty: Int = one_to_thirty + thirty * 9 + one_to_nine + forty;
    var one_to_fifty: Int = one_to_forty + forty * 9 + one_to_nine + fifty;
    var one_to_sixty: Int = one_to_fifty + fifty * 9 + one_to_nine + sixty;
    var one_to_seventy: Int = one_to_sixty + sixty * 9 + one_to_nine + seventy;
    var one_to_eighty: Int = one_to_seventy + seventy * 9 + one_to_nine + eighty;
    var one_to_ninety: Int = one_to_eighty + eighty * 9 + one_to_nine + ninety;
    var one_to_ninety_nine: Int = one_to_ninety + ninety * 9 + one_to_nine;
    printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + hundred_and * 9 * 99 + hundred * 9 + one + thousand);
  }
  
}

