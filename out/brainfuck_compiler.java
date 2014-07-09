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
    int[] mem = new int[a];
    for (int i = 0 ; i < a; i++)
      mem[i] = 0;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    current_pos ++;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    mem[current_pos] = mem[current_pos] + 1;
    while (mem[current_pos] != 0)
    {
      mem[current_pos] = mem[current_pos] - 1;
      current_pos --;
      mem[current_pos] = mem[current_pos] + 1;
      System.out.printf("%c", (char)(mem[current_pos]));
      current_pos ++;
    }
  }
  
}

