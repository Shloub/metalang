import java.util.*;

public class brainfuck_compiler
{
  static Scanner scanner = new Scanner(System.in);
  
  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  public static void main(String args[])
  {
    char input = ' ';
    int current_pos = 500;
    int a = 1000;
    int[] mem_ = new int[a];
    for (int i = 0 ; i < a; i++)
      mem_[i] = 0;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    current_pos ++;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    mem_[current_pos] = mem_[current_pos] + 1;
    while (mem_[current_pos] != 0)
    {
      mem_[current_pos] = mem_[current_pos] - 1;
      current_pos --;
      mem_[current_pos] = mem_[current_pos] + 1;
      char b = (char)(mem_[current_pos]);
      System.out.printf("%c", b);
      current_pos ++;
    }
  }
  
}

