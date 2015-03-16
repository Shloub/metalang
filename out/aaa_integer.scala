object aaa_integer
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
    var i: Int = 0;
    i = i - 1;
    printf("%d\n", i);
    i = i + 55;
    printf("%d\n", i);
    i = i * 13;
    printf("%d\n", i);
    i = i / 2;
    printf("%d\n", i);
    i = i + 1;
    printf("%d\n", i);
    i = i / 3;
    printf("%d\n", i);
    i = i - 1;
    printf("%d\n", i);
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", 117 / 17, 117 / -17, -117 / 17, -117 / -17, 117 % 17, 117 % -17, -117 % 17, -117 % -17);
  }
  
}

