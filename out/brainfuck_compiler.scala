object brainfuck_compiler
{
  
  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  def main(args : Array[String])
  {
    var input: Char = ' ';
    var current_pos: Int = 500;
    var mem :Array[Int] = new Array[Int](1000);
    for (i <- 0 to 999)
        mem(i) = 0;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    current_pos = current_pos + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    mem(current_pos) = mem(current_pos) + 1;
    while (mem(current_pos) != 0)
    {
        mem(current_pos) = mem(current_pos) - 1;
        current_pos = current_pos - 1;
        mem(current_pos) = mem(current_pos) + 1;
        printf("%c", (mem(current_pos)).toChar);
        current_pos = current_pos + 1;
    }
  }
  
}

