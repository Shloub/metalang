object vigenere
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
  
  def position_alphabet(c : Char): Int = {
    var i: Int = (c).toInt;
    if (i <= ('Z').toInt && i >= ('A').toInt)
        return i - ('A').toInt;
    else
        if (i <= ('z').toInt && i >= ('a').toInt)
            return i - ('a').toInt;
        else
            return -1;
  }
  
  def of_position_alphabet(c : Int): Char = {
    return (c + ('a').toInt).toChar;
  }
  
  def crypte(taille_cle : Int, cle : Array[Char], taille : Int, message : Array[Char]){
    for (i <- 0 to taille - 1)
    {
        var lettre: Int = position_alphabet(message(i));
        if (lettre != -1)
        {
            var addon: Int = position_alphabet(cle(i % taille_cle));
            var new0: Int = (addon + lettre) % 26;
            message(i) = of_position_alphabet(new0);
        }
    }
  }
  
  def main(args : Array[String])
  {
    var taille_cle = read_int();
    skip();
    var cle :Array[Char] = new Array[Char](taille_cle);
    for (index <- 0 to taille_cle - 1)
    {
        var out0 = read_char();
        cle(index) = out0;
    }
    skip();
    var taille = read_int();
    skip();
    var message :Array[Char] = new Array[Char](taille);
    for (index2 <- 0 to taille - 1)
    {
        var out2 = read_char();
        message(index2) = out2;
    }
    crypte(taille_cle, cle, taille, message);
    for (i <- 0 to taille - 1)
        printf("%c", message(i));
    printf("\n");
  }
  
}

