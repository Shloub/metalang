object prologin_template_2charline2
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

  def programme_candidat(tableau1 : Array[Char], taille1 : Int, tableau2 : Array[Char], taille2 : Int): Int = {
    var j: Int=0;
    var i: Int=0;
    var out0: Int = 0;
    for (i <- 0 to taille1 - 1)
    {
      out0 = out0 + (tableau1(i)).toInt * i;
      printf("%c", tableau1(i));
    }
    printf("--\n");
    for (j <- 0 to taille2 - 1)
    {
      out0 = out0 + (tableau2(j)).toInt * j * 100;
      printf("%c", tableau2(j));
    }
    printf("--\n");
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille1 = read_int()
    skip();
    var taille2 = read_int()
    skip();
    var tableau1 :Array[Char] = new Array[Char](taille1);
    for (a <- 0 to taille1 - 1)
      tableau1(a) = read_char()
    skip();
    var tableau2 :Array[Char] = new Array[Char](taille2);
    for (b <- 0 to taille2 - 1)
      tableau2(b) = read_char()
    skip();
    printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

