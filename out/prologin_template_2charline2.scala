object prologin_template_2charline2
{
  
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
    var taille1: Int = readInt().toInt;
    var taille2: Int = readInt().toInt;
    var tableau1: Array[Char] = readLine().toCharArray();
    var tableau2: Array[Char] = readLine().toCharArray();
    printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

