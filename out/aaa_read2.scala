object aaa_read2
{
  
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  def main(args : Array[String])
  {
    var len: Int = readInt().toInt;
    printf("%d=len\n", len);
    var tab: Array[Int] = readLine().split(" ").map(_.toInt);
    for (i <- 0 to len - 1)
      printf("%d=>%d ", i, tab(i));
    printf("\n");
    var tab2: Array[Int] = readLine().split(" ").map(_.toInt);
    for (i_0 <- 0 to len - 1)
      printf("%d==>%d ", i_0, tab2(i_0));
    var strlen: Int = readInt().toInt;
    printf("%d=strlen\n", strlen);
    var tab4: Array[Char] = readLine().toCharArray();
    for (i3 <- 0 to strlen - 1)
    {
        var tmpc: Char = tab4(i3);
        var c: Int = (tmpc).toInt;
        printf("%c:%d ", tmpc, c);
        if (tmpc != ' ')
          c = (c - ('a').toInt + 13) % 26 + ('a').toInt;
        tab4(i3) = (c).toChar;
    }
    for (j <- 0 to strlen - 1)
      printf("%c", tab4(j));
  }
  
}

