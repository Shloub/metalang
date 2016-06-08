object prologin_template_intlist
{
  
  def programme_candidat(tableau : Array[Int], taille : Int): Int = {
    var out0: Int = 0;
    for (i <- 0 to taille - 1)
        out0 = out0 + tableau(i);
    return out0;
  }
  
  
  def main(args : Array[String])
  {
    var taille: Int = readInt().toInt;
    var tableau: Array[Int] = readLine().split(" ").map(_.toInt);
    printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

