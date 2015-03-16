object brainfuck_compiler
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

  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  def main(args : Array[String])
  {
    var input: Char = ' ';
    var current_pos: Int = 500;
    var mem :Array[Int] = new Array[Int](1000);
    for (i <- 0 to 1000 - 1)
      mem(i) = 0;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    current_pos = current_pos + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    while (mem(current_pos) != 0)
    {
      mem(current_pos) = mem(current_pos) - 1;
      current_pos = current_pos - 1;
      mem(current_pos) = mem(current_pos) + 1;
      printf("%c", (mem(current_pos)).toChar);
      current_pos = current_pos + 1;
    }
  }
  
}

