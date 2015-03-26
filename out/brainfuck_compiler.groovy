import java.util.*;

public class brainfuck_compiler
{
  
  /*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
  
  static void main(String[] args)
  {
    char input = (char)' ';
    int current_pos = 500;
    int[] mem = new int[1000];
    for (int i = 0 ; i < 1000; i++)
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
      print((char)(mem[current_pos]));
      current_pos ++;
    }
  }
  
}

