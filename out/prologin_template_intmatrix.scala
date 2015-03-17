object prologin_template_intmatrix
{
  
  def programme_candidat(tableau : Array[Array[Int]], x : Int, y : Int): Int = {
    var i: Int=0;
    var j: Int=0;
    var out0: Int = 0;
    for (i <- 0 to y - 1)
      for (j <- 0 to x - 1)
        out0 = out0 + tableau(i)(j) * (i * 2 + j);
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille_x: Int = readInt().toInt;
    var taille_y: Int = readInt().toInt;
    var tableau :Array[Array[Int]] = new Array[Array[Int]](taille_y);
    for (a <- 0 to taille_y - 1)
      tableau(a) = readLine().split(" ").map(_.toInt);
    printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

