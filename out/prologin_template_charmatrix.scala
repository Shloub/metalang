object prologin_template_charmatrix
{
  
  def programme_candidat(tableau : Array[Array[Char]], taille_x : Int, taille_y : Int): Int = {
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
    var taille_x: Int = readInt().toInt;
    var taille_y: Int = readInt().toInt;
    var a :Array[Array[Char]] = new Array[Array[Char]](taille_y);
    for (b <- 0 to taille_y - 1)
        a(b) = readLine().toCharArray();
    var tableau: Array[Array[Char]] = a;
    printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

