object prologin_template_intmatrix
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

  def programme_candidat(tableau : Array[Array[Int]], x : Int, y : Int): Int = {
    var i: Int=0;
    var j: Int=0;
    var out0: Int = 0;
    for (i <- 0 to y - 1)
      for (j <- 0 to x - 1)
        out0 = out0 + tableau(i)(j) * (i * 2 + j);
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille_x = read_int()
    skip();
    var taille_y = read_int()
    skip();
    var tableau :Array[Array[Int]] = new Array[Array[Int]](taille_y);
    for (a <- 0 to taille_y - 1)
    {
      var b :Array[Int] = new Array[Int](taille_x);
      for (c <- 0 to taille_x - 1)
      {
        b(c) = read_int()
        skip();
      }
      tableau(a) = b;
    }
    printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

