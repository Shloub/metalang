object prologin_template_intlist
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
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def programme_candidat(tableau : Array[Int], taille : Int): Int = {
    var i: Int=0;
    var out0: Int = 0;
    for (i <- 0 to taille - 1)
      out0 = out0 + tableau(i);
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille = read_int()
    skip();
    var tableau :Array[Int] = new Array[Int](taille);
    for (a <- 0 to taille - 1)
    {
      tableau(a) = read_int()
      skip();
    }
    printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

