object aaa_10stringsarray
{
  
  /*
TODO ajouter un record qui contient des chaines.
*/
  def idstring(s : String): String = {
    return s;
  }
  
  def printstring(s : String){
    printf("%s\n", idstring(s));
  }
  
  
  def main(args : Array[String])
  {
    var tab :Array[String] = new Array[String](2);
    for (i <- 0 to 2 - 1)
      tab(i) = idstring("chaine de test");
    for (j <- 0 to 1)
      printstring(idstring(tab(j)));
  }
  
}

