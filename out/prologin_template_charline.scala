object prologin_template_charline
{
  
  def programme_candidat(tableau : Array[Char], taille : Int): Int = {
    var out0: Int = 0;
    for (i <- 0 to taille - 1)
    {
        out0 = out0 + (tableau(i)).toInt * i;
        printf("%c", tableau(i));
    }
    printf("--\n");
    return out0;
  }
  
  def main(args : Array[String])
  {
    var taille: Int = readInt().toInt;
    var tableau: Array[Char] = readLine().toCharArray();
    printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

