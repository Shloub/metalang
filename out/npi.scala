object npi
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
  
  def is_number(c : Char): Boolean = {
    return (c).toInt <= ('9').toInt && (c).toInt >= ('0').toInt;
  }
  
  /*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
  
  def npi0(str : Array[Char], len : Int): Int = {
    var stack :Array[Int] = new Array[Int](len);
    for (i <- 0 to len - 1)
        stack(i) = 0;
    var ptrStack: Int = 0;
    var ptrStr: Int = 0;
    while (ptrStr < len)
        if (str(ptrStr) == ' ')
            ptrStr = ptrStr + 1;
        else
            if (is_number(str(ptrStr)))
            {
                var num: Int = 0;
                while (str(ptrStr) != ' ')
                {
                    num = num * 10 + (str(ptrStr)).toInt - ('0').toInt;
                    ptrStr = ptrStr + 1;
                }
                stack(ptrStack) = num;
                ptrStack = ptrStack + 1;
            }
            else
                if (str(ptrStr) == '+')
                {
                    stack(ptrStack - 2) = stack(ptrStack - 2) + stack(ptrStack - 1);
                    ptrStack = ptrStack - 1;
                    ptrStr = ptrStr + 1;
                }
    return stack(0);
  }
  
  def main(args : Array[String])
  {
    var len: Int = 0;
    len = read_int();
    skip();
    var tab :Array[Char] = new Array[Char](len);
    for (i <- 0 to len - 1)
    {
        var tmp: Char = '\u0000';
        tmp = read_char();
        tab(i) = tmp;
    }
    var result: Int = npi0(tab, len);
    printf("%d", result);
  }
  
}

