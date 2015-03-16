object aaa_integer
{
  
  
  def main(args : Array[String])
  {
    var i: Int = 0;
    i = i - 1;
    printf("%d\n", i);
    i = i + 55;
    printf("%d\n", i);
    i = i * 13;
    printf("%d\n", i);
    i = i / 2;
    printf("%d\n", i);
    i = i + 1;
    printf("%d\n", i);
    i = i / 3;
    printf("%d\n", i);
    i = i - 1;
    printf("%d\n", i);
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", 117 / 17, 117 / -17, -117 / 17, -117 / -17, 117 % 17, 117 % -17, -117 % 17, -117 % -17);
  }
  
}

