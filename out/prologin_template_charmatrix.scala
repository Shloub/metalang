object prologin_template_charmatrix
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

  def programme_candidat(tableau : Array[Array[Char]], taille_x : Int, taille_y : Int): Int = {
    var i: Int=0;
    var j: Int=0;
    var out0: Int = 0;
    for (i <- 0 to taille_y - 1)
    {
      for (j <- 0 to taille_x - 1)
      {
        out0 = out0 + (tableau(i)(j)).toInt * (i + j * 2);
        printf("%c", tableau(i)(j));
      }
      printf("--\n");
    }
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille_x = read_int()
    skip();
    var taille_y = read_int()
    skip();
    var a :Array[Array[Char]] = new Array[Array[Char]](taille_y);
    for (b <- 0 to taille_y - 1)
    {
      var c :Array[Char] = new Array[Char](taille_x);
      for (d <- 0 to taille_x - 1)
        c(d) = read_char()
      skip();
      a(b) = c;
    }
    var tableau: Array[Array[Char]] = a;
    printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

