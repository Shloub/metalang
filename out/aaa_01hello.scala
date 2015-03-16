object aaa_01hello
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
    printf("Hello World");
    var a: Int = 5;
    printf("%d \n%dfoo", (4 + 6) * 2, a);
    var b: Boolean = 1 + ((1 + 1) * 2 * (3 + 8)) / 4 - (1 - 2) - 3 == 12 && true;
    if (b)
      printf("True");
    else
      printf("False");
    printf("\n");
    var c: Boolean = (3 * (4 + 5 + 6) * 2 == 45) == false;
    if (c)
      printf("True");
    else
      printf("False");
    printf("%d%d", ((4 + 1) / 3) / (2 + 1), ((4 * 1) / 3) / (2 * 1));
    var d: Boolean = !(!(a == 0) && !(a == 4));
    if (d)
      printf("True");
    else
      printf("False");
    var e: Boolean = true && !false && !(true && false);
    if (e)
      printf("True");
    else
      printf("False");
    printf("\n");
  }
  
}

