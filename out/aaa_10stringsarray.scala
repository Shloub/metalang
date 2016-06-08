object aaa_10stringsarray
{
  
  class Toto(_s: String, _v: Int){
    var s: String=_s;
    var v: Int=_v;
  }
  
  def idstring(s : String): String = {
    return s;
  }
  
  def printstring(s : String){
    printf("%s\n", idstring(s));
  }
  
  def print_toto(t : Toto){
    printf("%s = %d\n", t.s, t.v);
  }
  
  
  def main(args : Array[String])
  {
    var tab :Array[String] = new Array[String](2);
    for (i <- 0 to 2 - 1)
    
        tab(i) = idstring("chaine de test");
    for (j <- 0 to 1)
    
        printstring(idstring(tab(j)));
    print_toto(new Toto("one", 1));
  }
  
}

