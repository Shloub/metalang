object sumDiv
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

  def foo(){
    var a: Int = 0;
    /* test */
    a = a + 1;
    /* test 2 */
  }
  
  def foo2(){
    
  }
  
  def foo3(){
    if (1 == 1)
    {
        
    }
  }
  
  def sumdiv(n : Int): Int = {
    /* On désire renvoyer la somme des diviseurs */
    var out0: Int = 0;
    /* On déclare un entier qui contiendra la somme */
    for (i <- 1 to n)
    
        /* La boucle : i est le diviseur potentiel*/
        if (n % i == 0)
        {
            /* Si i divise */
            out0 = out0 + i;
            /* On incrémente */
        }
        else
        {
            /* nop */
        }
    return out0;
    /*On renvoie out*/
  }
  
  
  def main(args : Array[String])
  {
    /* Programme principal */
    var n: Int = 0;
    n = read_int();
    /* Lecture de l'entier */
    printf("%d", sumdiv(n));
  }
  
}

